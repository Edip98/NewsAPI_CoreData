//
//  UIView+Ext.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for views in views {
            addSubview(views)
        }
    }
}
