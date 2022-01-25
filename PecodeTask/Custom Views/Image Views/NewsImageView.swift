//
//  NewsImageView.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import UIKit

class NewsImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .secondarySystemBackground
        contentMode = .scaleAspectFill
        layer.cornerRadius = 6
        layer.masksToBounds = true
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
