//
//  SecondViewController.swift
//  CafeMario
//
//  Created by Maxim Raskevich on 01.09.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var checkBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // добавление заголовка для вью
        title = "Cafe Mario"
        // изменение шрифта заголовка и его размера
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        checkBtn.layer.cornerRadius = 7.0
        navigationItem.backButtonTitle = "Back"
    }
    
    @IBAction func toThirdViewController(_ sender: Any) {
        performSegue(withIdentifier: "toThird", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
