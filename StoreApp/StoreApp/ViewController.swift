//
//  ViewController.swift
//  StoreApp
//
//  Created by Maxim Raskevich on 05.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let img1 = UIImage(named: "backpack_1")
    let img2 = UIImage(named: "backpack_2")
    let img3 = UIImage(named: "backpack_3")
    
    lazy var imgsView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        if let img1 = img1, let img2 = img2, let img3 = img3 {
            imgView.animationImages = [img1, img2, img3]
        }
        imgView.animationDuration = 10
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .blue
        return imgView
    }()

    let blueView = BlueView()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Change radius", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        )
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    var heightConts: NSLayoutConstraint!
    var widthConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        //view.addSubview(imgsView)
//        NSLayoutConstraint.activate(
//            [
//                imgsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//                imgsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//                imgsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                imgsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
//            ]
//        )
//        imgsView.startAnimating()
        view.addSubview(blueView)
        view.addSubview(button)
        
        blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heightConts = blueView.heightAnchor.constraint(equalToConstant: 100)
        heightConts.isActive = true
        widthConst = blueView.widthAnchor.constraint(equalToConstant: 100)
        widthConst.isActive = true
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        view.layoutIfNeeded()
        if button.isSelected {
            UIView.animate(withDuration: 2) {
                self.heightConts.constant = 200
                self.widthConst.constant = 200
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 2) {
                self.heightConts.constant = 100
                self.widthConst.constant = 100
                self.view.layoutIfNeeded()
            }
        }
    }

}


class BlueView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        print("layoutSubviews")
    }
}
