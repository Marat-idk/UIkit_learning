//
//  Tools.swift
//  BirthdayReminder
//
//  Created by Marat
//

import UIKit

extension UITextField {
    // textfield с нижним подчеркиванием
    func underlined(color: UIColor) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
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
    // textfield с кнопкой Done
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
}

extension UITextField {
    // добавление иконки глаза
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(named: "eye closed"), for: .normal)
        } else {
            button.setImage(UIImage(named: "eye opened"), for: .normal)

        }
    }
    // кнопка глаза для филда
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
        self.addSubview(button)
        
        NSLayoutConstraint.activate(
            [
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                button.topAnchor.constraint(equalTo: self.topAnchor),
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                button.widthAnchor.constraint(equalToConstant: 25),
                button.heightAnchor.constraint(equalToConstant: 25)
            ]
        )
    }
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender as! UIButton)
    }
}
