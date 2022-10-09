//
//  CartViewController.swift
//  ShopApp
//
//  Created by Marat on 01.10.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    let emptyCart: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Карзина пуста 😢"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = .boldSystemFont(ofSize: 22)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSubView()
        setConstraints()
    }
    
    func setupSubView() {
        view.addSubview(emptyCart)
    }

    func setConstraints() {
        setupEmptyCartLabel()
    }
    
    func setupEmptyCartLabel() {
        emptyCart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyCart.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyCart.widthAnchor.constraint(equalToConstant: 220).isActive = true
        emptyCart.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

}
