//
//  OrderViewController.swift
//  Bringo
//
//  Created by Marat on 26.10.2022.
//

import UIKit

class OrderViewController: UIViewController {
    
    let pizzaName: String
    let toppings: [String]
    
    let orderLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Ваш заказ:"
        lbl.font = .systemFont(ofSize: 24)
        lbl.textAlignment = .left
        lbl.textColor = .darkGray
        return lbl
    }()
    
    var orderListLabel: UILabel!
    
    let cardLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Оплата картой"
        lbl.font = .systemFont(ofSize: 24)
        lbl.textAlignment = .left
        lbl.textColor = .darkGray
        return lbl
    }()
    
    let cardSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.isOn = true
        sw.tag = 0
        sw.addTarget(self, action: #selector(switchPayment(sender:)), for: .valueChanged)
        return sw
    }()
    
    let cashLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Наличными"
        lbl.font = .systemFont(ofSize: 24)
        lbl.textAlignment = .left
        lbl.textColor = .darkGray
        return lbl
    }()
    
    let cashSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.tag = 1
        sw.addTarget(self, action: #selector(switchPayment(sender:)), for: .valueChanged)
        return sw
    }()
    
    let payButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .black
        btn.setTitle("Pay", for: .normal)
        btn.setTitleColor(.systemGray5, for: .highlighted)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 24)
        btn.layer.cornerRadius = 7.0
        btn.addTarget(self, action: #selector(payBattonPressed), for: .touchUpInside)
        return btn
    }()
    
    init(pizzaName: String, toppings: [String]) {
        self.pizzaName = pizzaName
        self.toppings = toppings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        view.backgroundColor = .white
        title = "Оплата"
        
        generateOrderListLabel()
        setupNavigationVC()
        addSubviews()
        setConstraints()
    }
    
    func generateOrderListLabel() {
        // создаем список заказов
        var orderList = "1 Пицца \(pizzaName)"
        for (number, topping) in toppings.enumerated() {
            orderList += "\n\(number + 2) \(topping)"
        }
        
        orderListLabel = UILabel()
        orderListLabel.text = orderList
        orderListLabel.translatesAutoresizingMaskIntoConstraints = false
        orderListLabel.font = .systemFont(ofSize: 28)
        orderListLabel.textAlignment = .left
        orderListLabel.numberOfLines = 0
        orderListLabel.textColor = .darkGray
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
        view.addSubview(orderLabel)
        view.addSubview(orderListLabel)
        view.addSubview(cardLabel)
        view.addSubview(cashLabel)
        view.addSubview(cardSwitch)
        view.addSubview(cashSwitch)
        view.addSubview(payButton)
    }
    
    func setConstraints() {
        setupOrderLabelConstraints()
        setupOrderListLabelConstaints()
        setupSwitchLabels(cardLabel, equalTo: orderLabel, topConst: view.bounds.height / 1.8)
        setupSwitchLabels(cashLabel, equalTo: cardLabel, topConst: 20)
        setupSwitchesConstraints()
        setupButtonConstraints()
    }
    
    func setupOrderLabelConstraints() {
        orderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height / 13).isActive = true
        orderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        orderLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        orderLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func setupOrderListLabelConstaints() {
        orderListLabel.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 20).isActive = true
        orderListLabel.leadingAnchor.constraint(equalTo: orderLabel.leadingAnchor).isActive = true
        orderListLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupSwitchLabels(_ element: UIView, equalTo anotherElement: UIView, topConst: CGFloat) {
        element.topAnchor.constraint(lessThanOrEqualTo: anotherElement.bottomAnchor, constant: topConst).isActive = true
        element.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 6).isActive = true
        element.widthAnchor.constraint(equalToConstant: 170).isActive = true
        element.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupSwitchesConstraints() {
        cardSwitch.topAnchor.constraint(equalTo: cardLabel.topAnchor, constant: 2).isActive = true
        cardSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true

        cashSwitch.topAnchor.constraint(equalTo: cashLabel.topAnchor, constant: 2).isActive = true
        cashSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
    }
    
    func setupButtonConstraints() {
        // ограничение будет не менее заданного число (больше или равно)
        payButton.topAnchor.constraint(greaterThanOrEqualTo: cashLabel.bottomAnchor, constant: 15).isActive = true
        payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 6).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 6).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    
    @objc func switchPayment(sender: UISwitch) {
        if sender.tag == 0 {
            cashSwitch.isOn = !cardSwitch.isOn
        } else {
            cardSwitch.isOn = !cashSwitch.isOn
        }
    }
    
    @objc func payBattonPressed() {
        let alert = UIAlertController(title: "Заказ оплачен!", message: "Ваш заказ доставят в течении 15 минут!\nПриятного аппетита", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "ОК", style: .cancel) { _ in
            self.toFoodVC()
        }
        
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    // ну и хуйню написал
    func toFoodVC() {
        let presentVC = self.presentingViewController as? UINavigationController
        self.dismiss(animated: true) {
            let navigationController = presentVC?.presentingViewController as? UINavigationController
            presentVC?.dismiss(animated: true) {
                let _ = navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}
