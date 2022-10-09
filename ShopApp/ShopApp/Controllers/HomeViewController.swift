//
//  ViewController.swift
//  ShopApp
//
//  Created by Marat on 01.10.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var iphone13Button: CustomUIButton!
    var iphone14Button: CustomUIButton!
    
    private let devices = [
        Device(name: "iPhone 13",
               colors: [.midnight, .starlight, .pink],
               storagePrices: [128: 70_000, 256: 80_000, 512: 110_000]
              ),
        Device(name: "iPhone 14",
               colors: [.midnight, .starlight, .blue],
               storagePrices: [128: 95_000, 256: 105_000, 512: 125_000])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        iphone13Button = generateButton(title: devices[0].name, imageName: "iphone13_midnigth")
        iphone14Button = generateButton(title: devices[1].name, imageName: "iphone14_midnigth")
        
        setupSubView()
        setConstraints()
    }
    
    func generateButton(title: String, imageName: String?) -> CustomUIButton {
        var filled = CustomUIButton.Configuration.filled()
        filled.baseBackgroundColor = .white
        filled.attributedTitle = AttributedString(
            NSAttributedString(string: title,
                               attributes: [
                                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                            NSAttributedString.Key.foregroundColor: UIColor.black
                                           ]))
        if let name = imageName, let img = UIImage(named: name) {
            filled.image = img
        }
        
        let btn = CustomUIButton(configuration: filled, primaryAction: nil)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        btn.underlined(color: .lightGray)
        btn.addTarget(self, action: #selector(toDeviceVC(sender:)), for: .touchUpInside)
        return btn
    }
    
    @objc func toDeviceVC(sender: UIButton) {
        // not solid it all
        var deviceVC: DeviceViewController!
        if sender.titleLabel?.text == devices[0].name {
            let images = [UIImage(named: "iphone13_midnigth")!, UIImage(named: "iphone13_starligth")!, UIImage(named: "iphone13_pink")!]
            deviceVC = DeviceViewController(device: devices[0], deviceImages: images)
        } else if sender.titleLabel?.text == devices[1].name {
            let images = [UIImage(named: "iphone14_midnigth")!, UIImage(named: "iphone14_starligth")!, UIImage(named: "iphone14_blue")!]
            deviceVC = DeviceViewController(device: devices[1], deviceImages: images)
        } else {
            deviceVC = DeviceViewController(device: nil, deviceImages: nil)
        }
        navigationController?.pushViewController(deviceVC, animated: true)
    }
    
    func setupSubView() {
        view.addSubview(iphone13Button)
        view.addSubview(iphone14Button)
    }
    
    func setConstraints() {
        setupDeviceButton(button: iphone13Button, equalTo: view)
        setupDeviceButton(button: iphone14Button, equalTo: iphone13Button)
    }
    
    func setupDeviceButton(button btn: UIButton, equalTo anotherView: UIView) {
        if anotherView is UIButton {
            btn.topAnchor.constraint(equalTo: anotherView.bottomAnchor, constant: 10).isActive = true
        } else {
            btn.topAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        }
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        btn.imageView?.leadingAnchor.constraint(equalTo: btn.leadingAnchor).isActive = true
        btn.imageView?.widthAnchor.constraint(equalTo: btn.heightAnchor, multiplier: 0.75).isActive = true
        btn.imageView?.heightAnchor.constraint(equalTo: btn.heightAnchor, multiplier: 0.95).isActive = true
        
        btn.titleLabel?.leadingAnchor.constraint(equalTo: btn.imageView!.trailingAnchor, constant: 10).isActive = true
        btn.titleLabel?.centerYAnchor.constraint(equalTo: btn.centerYAnchor).isActive = true
    }
}

class CustomUIButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .systemGray4: .white
        }
    }
}
