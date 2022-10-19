//
//  FoodViewController.swift
//  Bringo
//
//  Created by Marat on 19.10.2022.
//

import UIKit

class FoodViewController: UIViewController {
    
    let pizzaButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Пицца", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let sushiButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Суши", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Food"
        
        setupNavigationVC()

        addSubviews()
        setConstraints()
    }
    
    func setupNavigationVC() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addSubviews() {
        view.addSubview(pizzaButton)
        view.addSubview(sushiButton)
    }
    
    func setConstraints() {
        pizzaButtonConstraints()
        sushiButtonConstraints()
    }
    
    func pizzaButtonConstraints() {
        pizzaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        pizzaButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        pizzaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height / 15).isActive = true
        pizzaButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 9).isActive = true
        print(view.bounds.height)
        print(view.bounds.height / 60)
        print(view.bounds.height / 100)
    }
    
    func sushiButtonConstraints() {
        sushiButton.leadingAnchor.constraint(equalTo: pizzaButton.leadingAnchor).isActive = true
        sushiButton.trailingAnchor.constraint(equalTo: pizzaButton.trailingAnchor).isActive = true
        sushiButton.topAnchor.constraint(equalTo: pizzaButton.bottomAnchor, constant: 20).isActive = true
        sushiButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 9).isActive = true

    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Извините", message: "Суши появятся позже", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(actionOk)
        // animated: true - плавный показ алерта
        self.present(alert, animated: true, completion: nil)
    }

}
