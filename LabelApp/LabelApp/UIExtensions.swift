//
//  UIExtensions.swift
//  LabelApp
//
//  Created by Marat on 13.11.2022.
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

extension UIColor {
    static var colors: [UIColor] = [.black, .darkGray, .gray, .red, .green, .blue, .magenta, .orange, .yellow, .purple]
    
    var name: String? {
        switch self {
        case .black: return "black"
        case .darkGray: return "darkGray"
        case .lightGray: return "lightGray"
        case .white: return "white"
        case .gray: return "gray"
        case .red: return "red"
        case .green: return "green"
        case .blue: return "blue"
        case .cyan: return "cyan"
        case .yellow: return "yellow"
        case .magenta: return "magenta"
        case .orange: return "orange"
        case .purple: return "purple"
        case .brown: return "brown"
        default: return nil
        }
    }
}
