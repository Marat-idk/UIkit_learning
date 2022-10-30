//
//  ViewController.swift
//  Bringo
//
//  Created by Marat on 15.10.2022.
//

import UIKit

class LoginViewConroller: UIViewController {
    
    let cloudImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "cloud")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let telephoneNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Телефон"
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let telephoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите номер"
        tf.keyboardType = .phonePad
        tf.clearButtonMode = .whileEditing
        tf.underlinder(color: .lightGray)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        toolbar.items = [space, done]
        tf.inputAccessoryView = toolbar
        
        return tf
    }()
    
    let passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Пароль"
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите пароль"
        tf.underlinder(color: .lightGray)
        tf.isSecureTextEntry = true
        tf.enablePasswordToggle()
        return tf
    }()
    
    let signInButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.systemGray5, for: .highlighted)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 7.0
        btn.backgroundColor = UIColor(red: 175/255, green: 199/255, blue: 247/255, alpha: 1)
        btn.addTarget(self, action: #selector(toFoodViewController), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        telephoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        
        addSubviews()
        setConstraints()
        setupTapGestureRecognizer()
    }
    
    func addSubviews() {
        view.addSubview(cloudImageView)
        view.addSubview(telephoneNumberLabel)
        view.addSubview(telephoneNumberTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
    }
    
    func setConstraints() {
        setupCloudImageView()
        setupTelephoneNumberLabel()
        setupTelephoneNumberTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupSignInButton()
    }
    
    
    func setupCloudImageView() {
        cloudImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cloudImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cloudImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cloudImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupTelephoneNumberLabel() {
        telephoneNumberLabel.topAnchor.constraint(equalTo: cloudImageView.bottomAnchor, constant: view.bounds.height / 6).isActive = true
        telephoneNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width / 9).isActive = true
        telephoneNumberLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        telephoneNumberLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setupTelephoneNumberTextField() {
        telephoneNumberTextField.leadingAnchor.constraint(equalTo: telephoneNumberLabel.leadingAnchor).isActive = true
        telephoneNumberTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width / 9).isActive = true
        telephoneNumberTextField.topAnchor.constraint(equalTo: telephoneNumberLabel.bottomAnchor).isActive = true
        telephoneNumberTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupPasswordLabel() {
        passwordLabel.topAnchor.constraint(equalTo: telephoneNumberTextField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: telephoneNumberTextField.leadingAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupPasswordTextField() {
        passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width / 9).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupSignInButton() {
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: view.bounds.height / 9).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func doneAction() {
        telephoneNumberTextField.resignFirstResponder()
    }
    
    
    @objc func toFoodViewController() {
        let foodVC = FoodViewController()
        let navigationController = UINavigationController(rootViewController: foodVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // устанавливаем в false чтобы получать вью получало все прикосновения
        // tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        //telephoneNumberTextField.resignFirstResponder()
        view.endEditing(true)
    }

    // mask example: `+X (XXX) XXX-XXXX`
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    // TODO: format for diff countries
//    func getFormatNumber(_ phoneNumber: String) -> String {
//        if phoneNumber.c
//    }
}

extension LoginViewConroller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != telephoneNumberTextField {
            return true
        }
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XX-XX", phone: newString)
        return false
    }

}
