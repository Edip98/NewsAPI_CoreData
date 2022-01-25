//
//  NewsSaveButton.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import UIKit

class NewsSaveButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func configure() {
        setImage(UIImage(systemName: "bookmark"), for: .normal)
        imageView?.tintColor = .black
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
         tag = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
