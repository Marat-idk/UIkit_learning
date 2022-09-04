//
//  ViewController.swift
//  CafeMario
//
//  Created by Marat on 01.09.2022.
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
        
        emailTextField.textFieldSettings(placeHolder: "Enter email", keyboardType: .emailAddress)
        passwordTextField.textFieldSettings(placeHolder: "Enter password")
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
    
    @IBAction func unwindSegueToMainScreen(_ seg: UIStoryboardSegue) {
        
    }

}

