//
//  NewsCell.swift
//  PecodeTask
//
//  Created by Эдип on 20.01.2022.
//

import UIKit
import CoreData

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item = [News]()
    
    let newsSourceLabel = NewsSourceLabel(fontSize: 9)
    let newsAuthorLabel = NewsAuthorLabel(fontSize: 12)
    let newsTitleLabel = NewsTitleLabel(fontSize: 16)
    let newsDescriptionLabel = NewsDescriptionLabel(fontSize: 14)
    let newsImageView = NewsImageView(frame: .zero)
    let newsSaveButton = NewsSaveButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubviews(newsAuthorLabel, newsTitleLabel, newsDescriptionLabel, newsImageView, newsSaveButton, newsSourceLabel)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemBackground
        selectedBackgroundView = backgroundView
        
        newsSaveButton.addTarget(self, action: #selector(newsSaveButtonPressed), for: .touchUpInside)
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 80),
            
            newsAuthorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            newsAuthorLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: padding),
            newsAuthorLabel.widthAnchor.constraint(equalToConstant: frame.size.width),
            newsAuthorLabel.heightAnchor.constraint(equalToConstant: 24),
            
            newsTitleLabel.topAnchor.constraint(equalTo: newsAuthorLabel.bottomAnchor, constant: -padding),
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: padding),
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsTitleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: padding),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: newsSaveButton.leadingAnchor, constant: -10),
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: newsSourceLabel.topAnchor),
            
            newsSourceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            newsSourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsSourceLabel.widthAnchor.constraint(equalToConstant: 100),
            newsSourceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            newsSaveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            newsSaveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            newsSaveButton.widthAnchor.constraint(equalToConstant: 25),
            newsSaveButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    @objc func newsSaveButtonPressed() {
        if newsSaveButton.tag == 0 {
            newsSaveButton.tag = 1
            newsSaveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            
            let newItem = News(context: self.context)
            newItem.author = newsAuthorLabel.text
            newItem.title = newsTitleLabel.text
            newItem.subtitle = newsDescriptionLabel.text
            newItem.source = newsSourceLabel.text
            newItem.image = newsImageView.image?.jpegData(compressionQuality: 0.9)
            
            item.append(newItem)
            saveData()
            
        } else {
            newsSaveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            newsSaveButton.tag = 0
            for item in item {
                context.delete(item)
                saveData()
            }
        }
    }
    
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Saving Error: \(error)")
        }
    }
    
    
    func set(with viewModel: NewsCellModel) {
        newsSourceLabel.text = viewModel.source
        newsAuthorLabel.text = viewModel.author
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
