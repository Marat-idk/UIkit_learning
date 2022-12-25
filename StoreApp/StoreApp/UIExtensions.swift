//
//  UIExtensions.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}


extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}

extension UIColor {
    static var darkTabBarColor: UIColor {
        return UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1.0)
    }
    
    static var lightTabBarColor: UIColor {
        return UIColor(red: 243 / 255, green: 243 / 255, blue: 244 / 255, alpha: 1.0)
    }
}
