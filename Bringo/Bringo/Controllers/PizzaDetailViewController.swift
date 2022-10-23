//
//  PizzaDetailViewController.swift
//  Bringo
//
//  Created by Marat on 23.10.2022.
//

import UIKit

class PizzaDetailViewController: UIViewController {
    
    var pizzaName: String
    var pizzaImage: UIImage
    
    var pizzaNameLabel: UILabel!
    var pizzaImageView: UIImageView!
    
    
    init(pizzaName: String, pizzaImage: UIImage) {
        self.pizzaName = pizzaName
        self.pizzaImage = pizzaImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        addSubviews()
        setConstraints()
    }
    
    // создание лейбла и имеджвью
    func configure() {
        configurePizzaNameLabel()
        configurePizzaImageView()
    }
    
    func configurePizzaNameLabel() {
        pizzaNameLabel = UILabel()
        pizzaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pizzaNameLabel.text = pizzaName
        pizzaNameLabel.font = .boldSystemFont(ofSize: 34)
        pizzaNameLabel.textColor = .darkGray
        pizzaNameLabel.textAlignment = .center
        // размер шрифта будет изменяться в зависимости от длины текста
        pizzaNameLabel.adjustsFontSizeToFitWidth = true
        pizzaNameLabel.numberOfLines = 0
    }
    
    func configurePizzaImageView() {
        pizzaImageView = UIImageView(image: pizzaImage)
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaImageView.contentMode = .scaleAspectFit
        pizzaImageView.clipsToBounds = true
    }
    
    // добавление сабвью
    func addSubviews() {
        view.addSubview(pizzaNameLabel)
        view.addSubview(pizzaImageView)
    }
    
    func setConstraints() {
        setupPizzaNameLabelConstraints()
        setupPizzaImageViewConstraints()
    }
    
    func setupPizzaNameLabelConstraints() {
        pizzaNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pizzaNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        pizzaNameLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        pizzaNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupPizzaImageViewConstraints() {
        pizzaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pizzaImageView.topAnchor.constraint(equalTo: pizzaNameLabel.bottomAnchor, constant: 10).isActive = true
        pizzaImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pizzaImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        pizzaImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }

}
