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
    
    private let cheese:   String
    private let ham:      String
    private let mushroom: String
    private let olive:    String
    var toppings: [String] = []
    
    lazy var cheeseLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = cheese
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textColor = .darkGray
        lbl.textAlignment = .left
        return lbl
    }()
    
    let cheeseSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.tag = 0
        sw.addTarget(self, action: #selector(switchTopping(_:)), for: .valueChanged)
        return sw
    }()
    
    lazy var hamLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ham
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textColor = .darkGray
        lbl.textAlignment = .left
        return lbl
    }()
    
    let hamSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.tag = 1
        sw.addTarget(self, action: #selector(switchTopping(_:)), for: .valueChanged)
        return sw
    }()
    
    lazy var mushroomsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = mushroom
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textColor = .darkGray
        lbl.textAlignment = .left
        return lbl
    }()
    
    let mushroomsSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.tag = 2
        sw.addTarget(self, action: #selector(switchTopping(_:)), for: .valueChanged)
        return sw
    }()
    
    lazy var olivesLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = olive
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textColor = .darkGray
        lbl.textAlignment = .left
        return lbl
    }()
    
    let olivesSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.tag = 3
        sw.addTarget(self, action: #selector(switchTopping(_:)), for: .valueChanged)
        return sw
    }()
    
    let chooseButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Выбрать", for: .normal)
        btn.setTitleColor(.systemGray5, for: .highlighted)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = UIColor(red: 240 / 255, green: 142 / 255, blue: 51 / 255, alpha: 1)
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(red: 237 / 255, green: 109 / 255, blue: 51 / 255, alpha: 1).cgColor
        btn.layer.cornerRadius = 7.0
        btn.addTarget(self, action: #selector(toOrderVC), for: .touchUpInside)
        return btn
    }()
    
    init(pizzaName: String, pizzaImage: UIImage) {
        self.pizzaName =  pizzaName
        self.pizzaImage = pizzaImage
        self.cheese =     "Сыр мацарела"
        self.ham =        "Ветчина"
        self.mushroom =   "Грибы"
        self.olive =      "Маслины"
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setDismissBatButton()
        configure()
        addSubviews()
        setConstraints()
    }
    
    func setDismissBatButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(dismissVC))
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
        view.addSubview(cheeseLabel)
        view.addSubview(hamLabel)
        view.addSubview(mushroomsLabel)
        view.addSubview(olivesLabel)
        view.addSubview(cheeseSwitch)
        view.addSubview(hamSwitch)
        view.addSubview(mushroomsSwitch)
        view.addSubview(olivesSwitch)
        view.addSubview(chooseButton)
    }
    
    func setConstraints() {
        setupPizzaNameLabelConstraints()
        setupPizzaImageViewConstraints()
        setupSwitchLabels(cheeseLabel, equalTo: pizzaImageView, topConst: 22)
        setupSwitchLabels(hamLabel, equalTo: cheeseLabel, topConst: 20)
        setupSwitchLabels(mushroomsLabel, equalTo: hamLabel, topConst: 20)
        setupSwitchLabels(olivesLabel, equalTo: mushroomsLabel, topConst: 20)
        setupSwitchesConstraints()
        setupButtonConstraints()
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
        // картинка пиццы будет меньше либо равна
        pizzaImageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupSwitchLabels(_ element: UIView, equalTo anotherElement: UIView, topConst: CGFloat) {
        element.topAnchor.constraint(equalTo: anotherElement.bottomAnchor, constant: topConst).isActive = true
        element.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 6).isActive = true
        element.widthAnchor.constraint(equalToConstant: 160).isActive = true
        element.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func setupSwitchesConstraints() {
        cheeseSwitch.topAnchor.constraint(equalTo: cheeseLabel.topAnchor, constant: 2).isActive = true
        cheeseSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
        
        hamSwitch.topAnchor.constraint(equalTo: hamLabel.topAnchor, constant: 2).isActive = true
        hamSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
        
        mushroomsSwitch.topAnchor.constraint(equalTo: mushroomsLabel.topAnchor, constant: 2).isActive = true
        mushroomsSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
        
        olivesSwitch.topAnchor.constraint(equalTo: olivesLabel.topAnchor, constant: 2).isActive = true
        olivesSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
    }
    
    func setupButtonConstraints() {
        // ограничение будет не менее заданного число (больше или равно)
        chooseButton.topAnchor.constraint(greaterThanOrEqualTo: olivesLabel.bottomAnchor, constant: 15).isActive = true
        chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        chooseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 6).isActive = true
        chooseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
        chooseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func switchTopping(_ sender: UISwitch) {
        if sender.tag < 0 || sender.tag > 3 { return }
        let ingredients = [cheese, ham, mushroom, olive]
        if sender.isOn {
            toppings.append(ingredients[sender.tag])
        } else {
            if let index = toppings.firstIndex(of: ingredients[sender.tag]) {
                toppings.remove(at: index)
            }
        }
        print(toppings)
    }
    
    @objc func toOrderVC() {
        let vc = OrderViewController(pizzaName: pizzaName, toppings: toppings)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
        //let navigationController = self.presentingViewController as? UINavigationController
        //self.dismiss(animated: true) {
        //    let _ = navigationController?.popToRootViewController(animated: true)
        //}
    }
}
