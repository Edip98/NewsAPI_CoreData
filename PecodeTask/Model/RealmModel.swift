//
//  RealmModel.swift
//  PecodeTask
//
//  Created by Эдип on 22.01.2022.
//

import Foundation
import UIKit
import RealmSwift


class RealmModel: Object {
    @objc dynamic var title: String?
    @objc dynamic var subtitle: String?    
}
