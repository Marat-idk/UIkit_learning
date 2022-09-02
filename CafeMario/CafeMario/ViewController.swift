//
//  ViewController.swift
//  CafeMario
//
//  Created by Maxim Raskevich on 01.09.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signInBtn.layer.cornerRadius = 7.0
        
        emailTextField.underlined(color: .lightGray)
        passwordTextField.underlined(color: .lightGray)
        
        emailTextField.placeholder = "Enter email"
        emailTextField.keyboardType = .emailAddress
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // закрытие textfield'a при нажатии return/ввод на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func toSecondViewController(_ sender: Any) {
        performSegue(withIdentifier: "toSecond", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

// textfield с нижним подчеркиванием
extension UITextField {
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
}

