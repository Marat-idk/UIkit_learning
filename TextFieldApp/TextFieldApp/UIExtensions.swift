//
//  UIExtensions.swift
//  TextFieldApp
//
//  Created by Marat on 18.11.2022.
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

extension UITextField {
    func underlined(color: UIColor) {
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = color
        self.addSubview(subView)
        NSLayoutConstraint.activate(
            [
                subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                subView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                subView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                subView.heightAnchor.constraint(equalToConstant: 1.0)
            ]
        )
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if self.isSecureTextEntry {
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        button.tintColor = .black
        self.rightView = button
        self.rightViewMode = .always
        self.addSubview(button)
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
    }
}

// нужно для динамического поднятия вью при появлении клавиатуры
extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }

    // Finds the current first responder
    // - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
