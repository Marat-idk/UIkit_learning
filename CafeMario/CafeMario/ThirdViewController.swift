//
//  ThirdViewController.swift
//  CafeMario
//
//  Created by Maxim Raskevich on 02.09.2022.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var totalBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Чек"
        // изменение шрифта заголовка и его размера
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        totalBtn.layer.cornerRadius = 7.0
    }
    
    
    @IBAction func toMainViewController(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
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
