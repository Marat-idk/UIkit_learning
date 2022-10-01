//
//  TestViewController.swift
//  ShopApp
//
//  Created by Marat on 01.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        let toPrevVCButton = UIButton(frame: .init(x: 0, y: 0, width: 200, height: 200))
        toPrevVCButton.center = view.center
        toPrevVCButton.setTitle("Go next", for: .normal)
        toPrevVCButton.backgroundColor = .systemPink
        toPrevVCButton.addTarget(self, action: #selector(toPrev), for: .touchUpInside)
        view.addSubview(toPrevVCButton)
    }
    
    @objc func toPrev() {
        navigationController?.popViewController(animated: true)
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
