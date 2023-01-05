//
//  UIExtensions.swift
//  AnimeAPI
//
//  Created by Marat on 05.01.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

}
