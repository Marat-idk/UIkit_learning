//
//  ViewController.swift
//  BirthdayReminder
//
//  Created by Marat on 09.09.2022.
//

import UIKit

class ViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Birthday Reminder"
        label.textColor = UIColor(red: 134/255, green: 165/255, blue: 200/255, alpha: 1)
        label.textAlignment = .center
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    let signinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign In"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        //label.backgroundColor = .blue
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        //label.backgroundColor = .red
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите email"
        tf.autocorrectionType = .no
        tf.keyboardType = .emailAddress
        // добавление очистки поля во время ввода
        tf.clearButtonMode = .whileEditing
        tf.underlined(color: .lightGray)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите пароль"
        tf.clearButtonMode = .whileEditing
        tf.underlined(color: .lightGray)
        tf.isSecureTextEntry.toggle()
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(signinLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(passwordTextField)
        
        setupTitleLable()
        setupSignInLabel()
        setupEmailLabel()
        setupPasswordLabel()
        
        setupTextField(element: emailTextField, equalTo: emailLabel, topConst: 10, widtdMultiplier: 0.75, heightConst: 40)
        setupTextField(element: passwordTextField, equalTo: passwordLabel, topConst: 10, widtdMultiplier: 0.75, heightConst: 40)
        
    }
    
    func setupTitleLable() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupSignInLabel() {
        signinLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        signinLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70).isActive = true
        signinLabel.widthAnchor.constraint(equalToConstant: 95).isActive = true
        signinLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupEmailLabel() {
        emailLabel.leftAnchor.constraint(equalTo: signinLabel.leftAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: signinLabel.bottomAnchor, constant: 15).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    func setupPasswordLabel() {
        passwordLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupTextField(element: UIView, equalTo someView: UIView, topConst: CGFloat, widtdMultiplier: CGFloat, heightConst: CGFloat) {
        element.leftAnchor.constraint(equalTo: someView.leftAnchor).isActive = true
        element.topAnchor.constraint(equalTo: someView.bottomAnchor, constant: topConst).isActive = true
        element.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widtdMultiplier).isActive = true
        element.heightAnchor.constraint(equalToConstant: heightConst).isActive = true
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
}

