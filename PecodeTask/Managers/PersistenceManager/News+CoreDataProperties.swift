//
//  News+CoreDataProperties.swift
//  PecodeTask
//
//  Created by Эдип on 25.01.2022.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var author: String?
    @NSManaged public var image: Data?
    @NSManaged public var source: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}

extension News : Identifiable {

}
