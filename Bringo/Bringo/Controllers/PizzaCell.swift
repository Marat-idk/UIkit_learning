//
//  PizzaCell.swift
//  Bringo
//
//  Created by Marat on 23.10.2022.
//

import UIKit

class PizzaCell: UITableViewCell {
    
    var pizzaImageView = UIImageView()
    var pizzaLabel = UILabel()
    let addButton: UIButton = {
        let btn = UIButton(type: .custom)
        if let image = UIImage(systemName: "plus") {
            btn.setImage(image, for: .normal)
            btn.tintColor = .white
        }
        btn.backgroundColor = UIColor(red: 240 / 255, green: 142 / 255, blue: 51 / 255, alpha: 1)
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(red: 237 / 255, green: 109 / 255, blue: 51 / 255, alpha: 1).cgColor
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return btn
    }()
    
    // клоужер задается из PizzaViewController
    var addButtonPressed: ((_ name: String, _ image: UIImage) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(pizzaImageView)
        addSubview(pizzaLabel)
        // если добавить просто как сабвью, то кнопка будет за ячейкой и ее невозможно будет нажать
        contentView.addSubview(addButton)
        
        configureImageView()
        configureLabel()
        
        setupImageViewConstraints()
        setupButtonConstraints()
        setupLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(pizza: Pizza) {
        pizzaLabel.text = pizza.name
        pizzaImageView.image = pizza.image
    }
    
    func configureImageView() {
        pizzaImageView.contentMode = .scaleAspectFit
        pizzaImageView.clipsToBounds = true
    }
    
    func configureLabel() {
        pizzaLabel.numberOfLines = 0
        pizzaLabel.adjustsFontSizeToFitWidth = true
        pizzaLabel.font = .boldSystemFont(ofSize: 22)
        pizzaLabel.textColor = .darkGray
    }
    
    func setupImageViewConstraints() {
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pizzaImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        pizzaImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        pizzaImageView.widthAnchor.constraint(equalTo: pizzaImageView.heightAnchor).isActive = true
    }
    
    func setupButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupLabelConstraints() {
        pizzaLabel.translatesAutoresizingMaskIntoConstraints = false
        pizzaLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pizzaLabel.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, constant: 10).isActive = true
        pizzaLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10).isActive = true
        pizzaLabel.heightAnchor.constraint(equalTo: pizzaImageView.heightAnchor).isActive = true
    }
    
    // вызывается клоужер, задаваемый в PizzaViewController
    @objc func addButtonAction() {
        if let name = pizzaLabel.text, let image = pizzaImageView.image,
            let addButtonPressed = addButtonPressed {
            addButtonPressed(name, image)
        }
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
