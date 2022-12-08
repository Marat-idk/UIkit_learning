//
//  BuyViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

class BuyViewController: UIViewController {
    
    let buyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Купить"
        lbl.font = .systemFont(ofSize: 30)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        view.addSubview(buyLabel)
        NSLayoutConstraint.activate(
            [
                buyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
