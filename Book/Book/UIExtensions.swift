//
//  UIExtensions.swift
//  Book
//
//  Created by Marat on 26.11.2022.
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
        views.forEach { self.addArrangedSubview($0) }
    }
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}

extension UIFont.Weight {
    var description: String {
        switch self {
        case .ultraLight: return "ultraLight"
        case .thin:       return "thin"
        case .light:      return "light"
        case .regular:    return "regular"
        case .medium:     return "medium"
        case .semibold:   return "semibold"
        case .bold:       return "bold"
        case .heavy:      return "heavy"
        case .black:      return "black"
        default:          return "unknown"
        }
    }
}

// получение ширины фона
extension UIFont {
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }

    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
            ?? [:]
    }
}

extension UISegmentedControl {
    // сброс выбранного сегмента до первого (дефолтного в моем случае)
    func reset() {
        if selectedSegmentIndex == 0 {
            return
        }
        UIView.animate(withDuration: 0.25) {
            self.selectedSegmentIndex = 0
        }
    }
}
