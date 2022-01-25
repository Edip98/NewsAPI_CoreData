//
//  NewsDescriptionLabel.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import UIKit

class NewsDescriptionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.numberOfLines = 3
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }
}
