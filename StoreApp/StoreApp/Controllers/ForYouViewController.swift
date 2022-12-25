//
//  ForYouViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

class ForYouViewController: UIViewController {
    
    private let profilePhotoKey = "profilePhoto"
    
    private let defaultProfilePhoto = UIImage(systemName: "person.circle.fill")
    
    private let airpods = Product(
                                name: "airpods",
                                images: [UIImage(named: "airpods")],
                                price: 10000,
                                colors: [.white])
    
    private lazy var profileButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(getProfileImage() ?? defaultProfilePhoto, for: .normal)
        btn.clipsToBounds = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let newsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Вот что нового"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 28)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private lazy var orderView: OrderView = {
        let orderView = OrderView(product: airpods)
        orderView.translatesAutoresizingMaskIntoConstraints = false
        return orderView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        
        
        setupNavigationController()
        
        
        view.addSubviews(newsLabel, orderView)
        
        setupConstraints()
    }
    
    private func setupNavigationController() {
        navigationController?.overrideUserInterfaceStyle = .light
        navigationItem.title = tabBarItem.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.layoutMargins.left = 15
        navigationController?.navigationBar.layoutMargins.right = 15
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .lightGray
        
        navigationController?.navigationBar.addSubviews(profileButton)
        view.addSubview(separator)
        
        NSLayoutConstraint.activate(
            [
                separator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                separator.heightAnchor.constraint(equalToConstant: 0.5)
            ]
        )
    }
    
    private func setupConstraints() {
        setupProfileButtonConstraints()
        setupNewsLabelConstraints()
        setupOrderViewConstraints()
    }
    
    // MARK: - устанавливаю констрейнты для profileButton
    private func setupProfileButtonConstraints() {
        let targetView = self.navigationController?.navigationBar
        let _ = NSLayoutConstraint(
                                                item: profileButton,
                                                attribute: .trailingMargin,
                                                relatedBy: .equal,
                                                toItem: targetView,
                                                attribute: .trailingMargin,
                                                multiplier: 1.0,
                                                constant: -8).isActive = true
        
        let _ = NSLayoutConstraint(
                                                item: profileButton,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: targetView,
                                                attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: -6).isActive = true
        
        profileButton.widthAnchor.constraint(equalToConstant: view.frame.height * 0.053).isActive = true
        profileButton.heightAnchor.constraint(equalTo: profileButton.widthAnchor).isActive = true
    }
    
    private func setupNewsLabelConstraints() {
        newsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        newsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        newsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupOrderViewConstraints() {
        orderView.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 20).isActive = true
        orderView.leadingAnchor.constraint(equalTo: newsLabel.leadingAnchor).isActive = true
        orderView.trailingAnchor.constraint(equalTo: newsLabel.trailingAnchor).isActive = true
        orderView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    private func getProfileImage() -> UIImage? {
        var image: UIImage?
        let userDefault = UserDefaults.standard
        // пытаемся получить данные по ключу
        if let data = userDefault.object(forKey: profilePhotoKey) as? Data {
            image = UIImage(data: data)
        }
        return image
    }
    
    private func setProfileImage(_ image: UIImage) {
        let userDefault = UserDefaults.standard
        // пытаемся конвертироать фото в тип Data
        if let data = image.pngData() {
            userDefault.set(data, forKey: profilePhotoKey)
        } else if let data = image.jpegData(compressionQuality: 1) {
            userDefault.set(data, forKey: profilePhotoKey)
        }
    }
    
    @objc private func profileButtonTapped(_ button: UIButton) {
        let imageVC = UIImagePickerController()
        imageVC.overrideUserInterfaceStyle = .light
        // will be remove in the future
        imageVC.sourceType = .photoLibrary
        // вкл возможность редактировать фото (например, обрезать)
        imageVC.allowsEditing = true
        imageVC.delegate = self
        present(imageVC, animated: true, completion: nil)
    }
    
    // MARK: - изменяю стиль tabbar'a на light
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let tabbarVC = tabBarController as? MainTabBarController else { return }
        tabbarVC.changeTabBarAppearance(to: .light)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileButton.layer.cornerRadius = profileButton.bounds.height / 2
    }
    
    // MARK: - возвращаю сстиль tabbar'a на dark
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let tabbarVC = tabBarController as? MainTabBarController else { return }
        tabbarVC.changeTabBarAppearance(to: .dark)
    }
}

extension ForYouViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newProfilePhoto: UIImage?
        
        if let photo = info[.editedImage] as? UIImage {
            newProfilePhoto = photo
        } else if let photo = info[.originalImage] as? UIImage {
            newProfilePhoto = photo
        }
        
        if let image = newProfilePhoto {
            profileButton.setBackgroundImage(image, for: .normal)
            setProfileImage(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // выбор отменен
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
