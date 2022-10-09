//
//  DeviceViewController.swift
//  ShopApp
//
//  Created by Marat on 09.10.2022.
//

import UIKit

class DeviceViewController: UIViewController {
    
    private var device: Device?
    
    var deviceNameLabel: UILabel!
    var deviceSegmentedConroller: UISegmentedControl!
    var deviceImageView: UIImageView!
    var deviceImages: [UIImage]?
    
    init(device: Device?, deviceImages: [UIImage]?) {
        self.device = device
        self.deviceImages = deviceImages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let device = device {
            print(device.name)
            for color in device.colors {
                print(color, terminator: " ")
            }
            print()
            for (storage, price) in device.storagePrices {
                print("storage \(storage) with price \(price)")
            }
        }
        generateDeviceNameLabel()
        generateSegmentedControl()
        generateImageView()
        addSubView()
        setConstraints()
    }
    
    func generateDeviceNameLabel() {
        deviceNameLabel = UILabel()
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.text = device!.name
        deviceNameLabel.font = .systemFont(ofSize: 22)
        deviceNameLabel.textAlignment = .center
    }
    
    func generateSegmentedControl() {
        if let colors = device?.colors {
            deviceSegmentedConroller = UISegmentedControl()
            deviceSegmentedConroller.translatesAutoresizingMaskIntoConstraints = false
            deviceSegmentedConroller.backgroundColor = .darkGray
            deviceSegmentedConroller.selectedSegmentTintColor = .systemGray2
            deviceSegmentedConroller.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)],
                                                            for: .normal)
            deviceSegmentedConroller.addTarget(self, action: #selector(changeImage(sender:)), for: .valueChanged)
            for color in colors {
                deviceSegmentedConroller.insertSegment(
                    withTitle: color.description,
                    at: deviceSegmentedConroller.numberOfSegments,
                    animated: false)
            }
        }
    }
    
    func generateImageView() {
        if let images = deviceImages {
            deviceImageView = UIImageView(image: images[0])
            deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addSubView() {
        view.addSubview(deviceNameLabel)
        view.addSubview(deviceImageView)
        view.addSubview(deviceSegmentedConroller)
    }

    func setConstraints() {
        setupNameLabel()
        setupImageView()
        setupSegmentedConroller()
    }
    
    func setupNameLabel() {
        deviceNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deviceNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        deviceNameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deviceNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupImageView() {
        deviceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deviceImageView.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 20).isActive = true
        deviceImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        deviceImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupSegmentedConroller() {
        deviceSegmentedConroller.topAnchor.constraint(equalTo: deviceImageView.bottomAnchor, constant: 20).isActive = true
        deviceSegmentedConroller.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deviceSegmentedConroller.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        deviceSegmentedConroller.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func changeImage(sender: UISegmentedControl) {
        if sender != deviceSegmentedConroller {
            return
        }
        guard let images = deviceImages else {
            return
        }
        let segmentIndex = sender.selectedSegmentIndex
        if segmentIndex >= 0 && segmentIndex < images.count {
            deviceImageView.image = images[segmentIndex]
        }
    }
}
