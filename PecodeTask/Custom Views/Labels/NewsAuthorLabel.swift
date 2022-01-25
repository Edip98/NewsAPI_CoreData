//
//  NewsAuthorLabel.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import UIKit

class NewsAuthorLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    
    private func configure() {
        textColor = .secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false
    }
}
