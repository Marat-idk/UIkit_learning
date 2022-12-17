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
    func insertSeparator(color: UIColor) {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = color
    
        self.addArrangedSubview(separator)
        
        NSLayoutConstraint.activate(
            [
                separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                separator.heightAnchor.constraint(equalToConstant: 1.0)
            ]
        )
        
    }
    
}
