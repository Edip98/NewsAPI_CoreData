//
//  NewsCellModel.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import Foundation

class NewsCellModel {
    
    let source: String
    let author: String
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(source: String, author: String, title: String, subtitle: String, imageURL: URL?) {
        self.source = source
        self.author = author
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
