//
//  ForYouViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

class ForYouViewController: UIViewController {
    
    let forYouLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Для вас"
        lbl.font = .systemFont(ofSize: 30)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        view.addSubview(forYouLabel)
        NSLayoutConstraint.activate(
            [
                forYouLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                forYouLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
}
