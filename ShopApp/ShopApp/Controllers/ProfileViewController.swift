//
//  TestViewController.swift
//  ShopApp
//
//  Created by Marat on 01.10.2022.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "ShopApp"
        lbl.font = .boldSystemFont(ofSize: 28)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.layer.borderWidth = 2.0
        lbl.layer.borderColor = UIColor.black.cgColor
        lbl.layer.cornerRadius = 7.0
        return lbl
    }()
    
    let signInLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Sign In"
        lbl.font = .boldSystemFont(ofSize: 26)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Email"
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = UIColor(red: 27 / 255, green: 74 / 255, blue: 252 / 255, alpha: 1)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите email"
        tf.keyboardType = .emailAddress
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.underlined(color: .lightGray)
        return tf
    }()
    
    let passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Password"
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = UIColor(red: 27 / 255, green: 74 / 255, blue: 252 / 255, alpha: 1)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите пароль"
        tf.autocorrectionType = .no
        tf.isSecureTextEntry = true
        tf.enablePasswordToggle()
        tf.underlined(color: .lightGray)
        return tf
    }()
    
    let signInButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.systemGray5, for: .highlighted)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = UIColor(red: 27 / 255, green: 74 / 255, blue: 252 / 255, alpha: 1)
        btn.layer.cornerRadius = 7.0
        btn.addTarget(self, action: #selector(toProfile), for: .touchUpInside)
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setupSubView()
        setConstraints()
        
    }
    
    func setupSubView() {
        view.addSubview(titleLabel)
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setConstraints() {
        setupTitleLabel()
        setupSignInLabel()
        setupAuthentication(element: emailLabel, equalTo: signInLabel, topConst: 20, heightConst: 20, widthConst: 45)
        setupAuthentication(element: emailTextField, equalTo: emailLabel, topConst: 5, heightConst: 40, widthConst: nil, widtdMultiplier: 0.85)
        
        setupAuthentication(element: passwordLabel, equalTo: emailTextField, topConst: 20, heightConst: 20, widthConst: 80)
        setupAuthentication(element: passwordTextField, equalTo: passwordLabel, topConst: 5, heightConst: 40, widthConst: nil, widtdMultiplier: 0.85)
        
        setupAuthentication(element: signInButton, equalTo: passwordTextField, topConst: 50, heightConst: 50, widthConst: nil, widtdMultiplier: 0.85)
    }
    
    func setupTitleLabel() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupSignInLabel() {
        signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.maxX / 13).isActive = true
        signInLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: view.frame.maxY / 7.5 ).isActive = true
        signInLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        signInLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupAuthentication(element: UIView, equalTo someView: UIView, topConst: CGFloat, heightConst: CGFloat, widthConst: CGFloat? = nil, widtdMultiplier: CGFloat? = nil) {
        element.leadingAnchor.constraint(equalTo: someView.leadingAnchor).isActive = true
        element.topAnchor.constraint(equalTo: someView.bottomAnchor, constant: topConst).isActive = true
        element.heightAnchor.constraint(equalToConstant: heightConst).isActive = true
        if let multi = widtdMultiplier {
            element.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multi).isActive = true
        } else if let widthConst = widthConst {
            element.widthAnchor.constraint(equalToConstant: widthConst).isActive = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    @objc func toProfile() {
        let profileSignInVc = ProfileSignInViewController()
        navigationController?.pushViewController(profileSignInVc, animated: true)
    }
}

// виью контроллер, который отображается при входе в профиль
class ProfileSignInViewController: UIViewController {
    
    let errorLable: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Упс!\nЧто-то пошло не так"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = .boldSystemFont(ofSize: 22)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(errorLable)
        errorLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLable.widthAnchor.constraint(equalToConstant: 220).isActive = true
        errorLable.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
