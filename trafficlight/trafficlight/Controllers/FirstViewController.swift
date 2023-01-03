//
//  ViewController.swift
//  trafficlight
//
//  Created by Marat on 31.12.2022.
//

import UIKit

// Auto-layout in storyboard
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

