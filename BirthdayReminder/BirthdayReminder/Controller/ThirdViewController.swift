//
//  ThirdViewController.swift
//  BirthdayReminder
//
//  Created by Marat on 14.09.2022.
//

import UIKit

class ThirdViewController: UIViewController {
    let hello: UILabel = {
       let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        lbl.text = "Hello"
        lbl.textAlignment = .center
        lbl.backgroundColor = .blue
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationController()
        hello.center = self.view.center
        self.view.addSubview(hello)
    }
    
    func setupNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(doneButton(_:)))    }
    
    @objc func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButton(_ sender: Any) {
        
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
