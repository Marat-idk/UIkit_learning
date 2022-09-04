//
//  ThirdViewController.swift
//  CafeMario
//
//  Created by Marat on 02.09.2022.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var totalBtn: UIButton!
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Чек"
        // изменение шрифта заголовка и его размера
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        totalBtn.titleLabel?.text = "Итого: \(totalPrice) руб."
        totalBtn.layer.cornerRadius = 7.0
    }
    
    
    @IBAction func toMainViewController(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
}
