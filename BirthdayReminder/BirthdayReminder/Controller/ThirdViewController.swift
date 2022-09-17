//
//  ThirdViewController.swift
//  BirthdayReminder
//
//  Created by Marat on 14.09.2022.
//

import UIKit

class ThirdViewController: UIViewController {
    weak var secondVCDelegate: SecondVCDelegate?
    var name: String?
    var birthday: Date?
    var age: Int?
    var sex: Sex?
    var instNickname: String?
    
    var avatar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "avatar")
        img.backgroundColor = .systemGray5
        return img
    }()
    
    var changeImgBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изменить фото", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(UIColor(red: 216/255, green: 234/255, blue: 254/255, alpha: 1), for: .highlighted)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(avatar)
        self.view.addSubview(changeImgBtn)
        setupNavigationController()
        setupAvatar()
        setupChangeImgBtn()
    }
    
    func setupNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(doneButton(_:)))    }
    
    @objc func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButton(_ sender: Any) {
        secondVCDelegate?.update(person: Person(name: name ?? "", birthday: birthday ?? Date(), age: age ?? 0, sex: sex, instNickname: instNickname))
        dismiss(animated: true, completion: nil)
    }
    
    func setupAvatar() {
        avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupChangeImgBtn() {
        changeImgBtn.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10).isActive = true
        changeImgBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeImgBtn.widthAnchor.constraint(equalToConstant: 130).isActive = true
        changeImgBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    // округление изображения
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setRounded()
    }

    
    func setRounded() {
        avatar.layer.cornerRadius = avatar.frame.size.height / 2
        avatar.clipsToBounds = true
    }
    

}
