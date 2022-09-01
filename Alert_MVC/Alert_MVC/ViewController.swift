//
//  ViewController.swift
//  Alert_MVC
//
//  Created by Maxim Raskevich on 01.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    
    var myReverser = Reverser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        helloLabel.text = ""
        helloLabel.numberOfLines = 0
        let alert = UIAlertController(title: "Введите слово", message: "Пожалуйства, введите слово", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { action in
            self.myReverser.str = alert.textFields?.first?.text
            self.myReverser.reverse()
            self.helloLabel.text! = self.myReverser.str!
        }
        alert.addTextField { textField in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    

}

