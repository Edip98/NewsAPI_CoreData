//
//  NewsFavCellModel.swift
//  PecodeTask
//
//  Created by Эдип on 24.01.2022.
//

import Foundation

class NewsFavCellModel {
    
    let title: String
    let subtitle: String
    let image: Data?
    
    init(title: String, subtitle: String, image: Data) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
