//
//  UIExtensions.swift
//  Bringo
//
//  Created by Marat on 17.10.2022.
//

import Foundation
import UIKit


extension UITextField {
    func underlinder(color: UIColor) {
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = color
        self.addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: 1.0)
            ]
        )
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        // установление изображения для иконки
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
        self.rightView = button
        self.rightViewMode = .always
        self.addSubview(button)
        
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
    }
}
