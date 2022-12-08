//
//  CartViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    let cartLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Корзина"
        lbl.font = .systemFont(ofSize: 30)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        view.addSubview(cartLabel)
        NSLayoutConstraint.activate(
            [
                cartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                cartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }

}
