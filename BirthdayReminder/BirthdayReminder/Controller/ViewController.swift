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
        tf.autocorrectionType = .no
        tf.underlined(color: .lightGray)
        tf.isSecureTextEntry.toggle()
        tf.enablePasswordToggle()
        return tf
    }()
    
    let faceidLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход по Face ID"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let faceidSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    let signinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.systemGray5, for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 175/255, green: 199/255, blue: 247/255, alpha: 1)
        button.layer.cornerRadius = 7.0
        button.addTarget(self, action: #selector(toSecondViewController(_:)), for: .touchUpInside)
        return button
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
        self.view.addSubview(faceidLabel)
        self.view.addSubview(faceidSwitch)
        self.view.addSubview(signinButton)
        
        setupTitleLable()
        setupSignInLabel()
        
        setupLabel(element: emailLabel, equalTo: signinLabel, topConst: 15, widthConst: 45, heighConst: 25)
        setupLabel(element: passwordLabel, equalTo: emailLabel, topConst: 60, widthConst: 80, heighConst: 25)
        
        setupTextField(element: emailTextField, equalTo: emailLabel, topConst: 0, widtdMultiplier: 0.75, heightConst: 40)
        setupTextField(element: passwordTextField, equalTo: passwordLabel, topConst: 0, widtdMultiplier: 0.75, heightConst: 40)
        
        setupSwitch()
        setupFaceIDLabel()
        setupSignInButton()
        
    }
    
    func setupTitleLable() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupSignInLabel() {
        signinLabel.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: view.leadingAnchor, multiplier: 6).isActive = true
        //signinLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        signinLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70).isActive = true
        signinLabel.widthAnchor.constraint(equalToConstant: 95).isActive = true
        signinLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupLabel(element: UIView, equalTo someView: UIView, topConst: CGFloat, widthConst: CGFloat, heighConst: CGFloat) {
        element.leadingAnchor.constraint(equalTo: someView.leadingAnchor).isActive = true
        element.topAnchor.constraint(equalTo: someView.bottomAnchor, constant: topConst).isActive = true
        element.widthAnchor.constraint(equalToConstant: widthConst).isActive = true
        element.heightAnchor.constraint(equalToConstant: heighConst).isActive = true
    }
    
    func setupTextField(element: UIView, equalTo someView: UIView, topConst: CGFloat, widtdMultiplier: CGFloat, heightConst: CGFloat) {
        element.leadingAnchor.constraint(equalTo: someView.leadingAnchor).isActive = true
        element.topAnchor.constraint(equalTo: someView.bottomAnchor, constant: topConst).isActive = true
        element.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widtdMultiplier).isActive = true
        element.heightAnchor.constraint(equalToConstant: heightConst).isActive = true
    }
    
    func setupSwitch() {
        faceidSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        faceidSwitch.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
    }
    
    func setupFaceIDLabel() {
        faceidLabel.trailingAnchor.constraint(equalTo: faceidSwitch.leadingAnchor, constant: -10).isActive = true
        faceidLabel.topAnchor.constraint(equalTo: faceidSwitch.topAnchor, constant: 3).isActive = true
        faceidLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        faceidLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupSignInButton() {
        signinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signinButton.topAnchor.constraint(equalTo: faceidLabel.bottomAnchor, constant: 50).isActive = true
        signinButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        signinButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func toSecondViewController(_ sender: UIButton) {
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* code */
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
}

