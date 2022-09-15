//
//  SecondViewController.swift
//  BirthdayReminder
//
//  Created by Marat on 13.09.2022.
//

import UIKit

protocol SecondVCDelegate {
    func update()
}

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationController()
    }
    
    func setupNavigationController() {
        title = "Birthday"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray5
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toThirdViewController(_:)))
        
    }
    
    @objc func toThirdViewController(_ sender: Any) {
        performSegue(withIdentifier: "toThirdVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? ThirdViewController else { return }
        dvc.hello.backgroundColor = .lightGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance = .none
    }

}
