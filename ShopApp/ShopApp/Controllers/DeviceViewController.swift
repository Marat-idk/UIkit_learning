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
    var totalPriceLabel: UILabel!
    var storage: Int?
    
    let storageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Память"
        lbl.font = .systemFont(ofSize: 22)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let storagePicker: UIPickerView = {
        let pv = UIPickerView()
        pv.tag = 0
        return pv
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Стоимость"
        lbl.font = .systemFont(ofSize: 22)
        lbl.textAlignment = .left
        return lbl
    }()
        
    let storageTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 6.0
        return tf
    }()
    
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
        
        // для числа компонент и числа строк в каждой из них
        storagePicker.dataSource = self
        // для названия компонент
        storagePicker.delegate = self
        
        generateViews()
        addSubView()
        setConstraints()
        setupShareButton()
    }
    
    func generateViews() {
        generateDeviceNameLabel()
        generateSegmentedControl()
        generateImageView()
        generateStoragePicker()
        generateTotalPriceLabel()
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
            deviceSegmentedConroller.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)],
                                                            for: .selected)

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
    
    // создаем пикер с вариантами памяти девайса
    func generateStoragePicker() {
        storageTextField.text = String(device!.storagePrices.keys.first!) + " гб"
        storage = device!.storagePrices.keys.first!
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(donePicker(_:)))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        storageTextField.inputAccessoryView = toolbar
        storageTextField.inputView = storagePicker
        // disable input blinking cursor
        storageTextField.tintColor = .clear
    }
    
    // лейбл с ценой
    func generateTotalPriceLabel() {
        totalPriceLabel = UILabel()
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        let storage = Int(storageTextField.text!.prefix(3))
        if storage != nil, let price = device?.storagePrices[storage!] {
            totalPriceLabel.text = String(price) + " руб."
            totalPriceLabel.font = .boldSystemFont(ofSize: 22)
            totalPriceLabel.textAlignment = .right
        }
    }
    
    func addSubView() {
        view.addSubview(deviceNameLabel)
        view.addSubview(deviceImageView)
        view.addSubview(deviceSegmentedConroller)
        view.addSubview(storageLabel)
        view.addSubview(storageTextField)
        view.addSubview(priceLabel)
        view.addSubview(totalPriceLabel)
    }

    func setConstraints() {
        setupNameLabel()
        setupImageView()
        setupSegmentedConroller()
        setupStorageLabel()
        setupStoragePicker()
        setupPriceLabel()
        setupTotalPriceLabel()
    }
    
    func setupNameLabel() {
        deviceNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deviceNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        deviceNameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deviceNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupImageView() {
        deviceImageView.image = deviceImageView.image?.resize(size: CGSize(width: 300, height: 300))
//        let w = (view.frame.width * 0.3)/view.frame.width
//        let h = (view.frame.height * 0.3)/view.frame.height
        deviceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deviceImageView.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 20).isActive = true
        deviceImageView.widthAnchor.constraint(equalToConstant: deviceImageView.image!.size.width).isActive = true
        deviceImageView.heightAnchor.constraint(equalToConstant: deviceImageView.image!.size.height).isActive = true
    }
    
    func setupSegmentedConroller() {
        deviceSegmentedConroller.topAnchor.constraint(equalTo: deviceImageView.bottomAnchor, constant: 20).isActive = true
        deviceSegmentedConroller.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deviceSegmentedConroller.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        deviceSegmentedConroller.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupStorageLabel() {
        storageLabel.topAnchor.constraint(equalTo: deviceSegmentedConroller.bottomAnchor, constant: 20).isActive = true
        storageLabel.leadingAnchor.constraint(equalTo: deviceSegmentedConroller.leadingAnchor, constant: 20).isActive = true
        storageLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
        storageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupStoragePicker() {
        storageTextField.topAnchor.constraint(equalTo: deviceSegmentedConroller.bottomAnchor, constant: 15).isActive = true
        storageTextField.trailingAnchor.constraint(equalTo: deviceSegmentedConroller.trailingAnchor, constant: -20).isActive = true
        storageTextField.widthAnchor.constraint(equalToConstant: 85).isActive = true
        storageTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupPriceLabel() {
        priceLabel.topAnchor.constraint(equalTo: storageLabel.bottomAnchor, constant: 20).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: storageLabel.leadingAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupTotalPriceLabel() {
        totalPriceLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        totalPriceLabel.trailingAnchor.constraint(equalTo: storageTextField.trailingAnchor).isActive = true
        totalPriceLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        totalPriceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
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
    
    // done батн для пикера
    @objc func donePicker(_ sender: UIPickerView) {
        guard let storage = storage, let device = device else { return }
        storageTextField.text = String(storage) + " гб"
        totalPriceLabel.text = String(device.storagePrices[storage]!) + " руб."
        
        self.view.endEditing(true)
    }
    
    // cancel батн для пикера
    @objc func cancelPicker() {
        // убрать пикер по кнопке cancel
        self.view.endEditing(true)
    }
    
    func setupShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
    }
    
    @objc func share(_ sender: UIBarButtonItem) {
        let activityVC = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        // исключаем отправку в некоторые таргеты
        activityVC.excludedActivityTypes = [.airDrop, .postToTwitter]
        // правильное отображение на айпаде
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(activityVC, animated: true, completion: nil)
    }
    
}


extension DeviceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return device!.storagePrices.count
        }
        return 0
    }
}

extension DeviceViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            guard let device = device else { return "" }
            let keys = Array(device.storagePrices.keys).sorted()
            return String(keys[row]) + " гб"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            guard let device = device else { return }
            let keys = Array(device.storagePrices.keys).sorted()
            storage = keys[row]
        }
    }
}

extension DeviceViewController: UIActivityItemSource {
    // используется только для того, чтобы UIKit знал тип данных, которыми нужно поделиться
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "placeholer"
    }
    // content
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        guard let device = device, let storage = storage else { return "" }
        let colorIndex = deviceSegmentedConroller.selectedSegmentIndex >= 0 ? deviceSegmentedConroller.selectedSegmentIndex : 0
        return "\(device.name), \(device.colors[colorIndex]) \(storage) гб \(device.storagePrices[storage]!) руб."
    }
    // subject of msg
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "Device"
    }
}
