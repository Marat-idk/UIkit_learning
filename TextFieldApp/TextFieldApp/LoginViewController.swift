//
//  ViewController.swift
//  TextFieldApp
//
//  Created by Marat on 17.11.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let appTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "TextFieldApp"
        lbl.font = .boldSystemFont(ofSize: 28)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.layer.borderWidth = 1.0
        lbl.layer.cornerRadius = 7.0
        return lbl
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Имя"
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tag = 0
        tf.placeholder = "Введите имя"
        tf.underlined(color: .lightGray)
        tf.clearButtonMode = .whileEditing
        // отключение автокоррекции
        tf.autocorrectionType = .no
        tf.returnKeyType = .next
        return tf
    }()
    
    let surnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Фамилия"
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    let surnameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tag = 1
        tf.placeholder = "Введите фамилию"
        tf.underlined(color: .lightGray)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.returnKeyType = .next
        return tf
    }()
    
    let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Имя пользователя"
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tag = 2
        tf.placeholder = "Введите имя пользователя"
        tf.underlined(color: .lightGray)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.returnKeyType = .next
        return tf
    }()
    
    let passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Пароль"
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tag = 3
        tf.placeholder = "Введите пароль"
        tf.underlined(color: .lightGray)
        tf.isSecureTextEntry = true
        tf.enablePasswordToggle()
        tf.returnKeyType = .done
        return tf
    }()
    
    let signInButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.systemGray5, for: .highlighted)
        btn.backgroundColor = .black
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 7.0
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubviews(
            appTitleLabel, nameLabel, nameTextField,
            surnameLabel, surnameTextField,
            usernameLabel, usernameTextField,
            passwordLabel, passwordTextField, signInButton
        )
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // подписываемся под события
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setConstraints()
        setupTapGestureRecognizer()
    }
    
    func setConstraints() {
        setupAppTitleConstraints()
        //name
        setupLoginViewsConstraints(element: nameLabel, equalTo: appTitleLabel, topConst: view.frame.height / 5.9)
        setupLoginViewsConstraints(element: nameTextField, equalTo: nameLabel, topConst: 0)
        //surname
        setupLoginViewsConstraints(element: surnameLabel, equalTo: nameTextField, topConst: 20)
        setupLoginViewsConstraints(element: surnameTextField, equalTo: surnameLabel, topConst: 0)
        //username
        setupLoginViewsConstraints(element: usernameLabel, equalTo: surnameTextField, topConst: 20)
        setupLoginViewsConstraints(element: usernameTextField, equalTo: usernameLabel, topConst: 0)
        //password
        setupLoginViewsConstraints(element: passwordLabel, equalTo: usernameTextField, topConst: 20)
        setupLoginViewsConstraints(element: passwordTextField, equalTo: passwordLabel, topConst: 0)
        //button
        setupButtonConstraint()
    }
    
    func setupAppTitleConstraints() {
        appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        appTitleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func setupLoginViewsConstraints(element: UIView, equalTo: UIView, topConst: CGFloat, heightConst: CGFloat? = nil) {
        element.topAnchor.constraint(equalTo: equalTo.bottomAnchor, constant: topConst).isActive = true
        element.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 9).isActive = true
        if element is UITextField {
            element.heightAnchor.constraint(equalToConstant: 40).isActive = true
            element.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 9).isActive = true
        }
    }
    
    func setupButtonConstraint() {
        signInButton.topAnchor.constraint(lessThanOrEqualTo: passwordTextField.bottomAnchor, constant: view.bounds.height / 9).isActive = true
        signInButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }

    // dismissing keyboard when tapping outside
    func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
      if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
         nextField.becomeFirstResponder()
      } else {
         // Not found, so remove keyboard.
         textField.resignFirstResponder()
      }
      // Do not add a line break
      return false
    }
}
