//
//  ViewController.swift
//  ShopApp
//
//  Created by Maxim Raskevich on 01.10.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .magenta
        
        let toNextVCButton = UIButton(frame: .init(x: 0, y: 0, width: 200, height: 200))
        toNextVCButton.center = view.center
        toNextVCButton.setTitle("Go next", for: .normal)
        toNextVCButton.backgroundColor = .systemPink
        toNextVCButton.addTarget(self, action: #selector(toNextVC), for: .touchUpInside)
        view.addSubview(toNextVCButton)
    }
    
    @objc func toNextVC() {
        let testVC = TestViewController()
        navigationController?.pushViewController(testVC, animated: true)
    }


}

