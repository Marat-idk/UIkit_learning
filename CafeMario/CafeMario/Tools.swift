//
//  Tools.swift
//  CafeMario
//
//  Created by Marat
//

import UIKit

extension UITextField {
    // textfield с нижним подчеркиванием
    func underlined(color: UIColor) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.borderStyle = .none
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
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
    func textFieldSettings(placeHolder: String, keyboardType: UIKeyboardType = .default, color: UIColor = .lightGray) {
        self.underlined(color: color)
        self.placeholder = placeHolder
        self.keyboardType = keyboardType
    }
}
