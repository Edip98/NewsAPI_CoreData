//
//  NewsFavoritesCell.swift
//  PecodeTask
//
//  Created by Эдип on 21.01.2022.
//

import UIKit

class NewsFavoritesCell: UITableViewCell {
    
    static let identifier = "NewsFavoritesCell"
    
    let newsSourceLabel = NewsSourceLabel(fontSize: 9)
    let newsAuthorLabel = NewsAuthorLabel(fontSize: 12)
    let newsTitleLabel = NewsTitleLabel(fontSize: 16)
    let newsDescriptionLabel = NewsDescriptionLabel(fontSize: 14)
    let newsImageView = NewsImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentView.addSubviews(newsAuthorLabel, newsTitleLabel, newsDescriptionLabel, newsImageView, newsSourceLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 80),
            
            newsAuthorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            newsAuthorLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: padding),
            newsAuthorLabel.widthAnchor.constraint(equalToConstant: frame.size.width),
            newsAuthorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            newsTitleLabel.topAnchor.constraint(equalTo: newsAuthorLabel.bottomAnchor),
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: padding),
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            newsTitleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: padding),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: newsSourceLabel.topAnchor),
            
            newsSourceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            newsSourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            newsSourceLabel.widthAnchor.constraint(equalToConstant: 100),
            newsSourceLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    
    func set(with favorites: News) {
        newsAuthorLabel.text = favorites.author
        newsTitleLabel.text = favorites.title
        newsDescriptionLabel.text = favorites.subtitle
        newsSourceLabel.text = favorites.source
        let data = UIImage(data: favorites.image!)
        newsImageView.image = data
    }
}

