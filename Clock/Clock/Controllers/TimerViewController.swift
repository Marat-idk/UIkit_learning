//
//  ViewController.swift
//  Clock
//
//  Created by Maxim Raskevich on 31.10.2022.
//

import UIKit

class TimerViewController: UIViewController {
    
    let timerPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Отмена", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        btn.backgroundColor = .secondarySystemFill
        return btn
    }()
    
    let startButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Старт", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        btn.backgroundColor = UIColor(red: 23 / 255, green: 55 / 255, blue: 26 / 255, alpha: 1)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        timerPickerView.dataSource = self
        timerPickerView.delegate = self
        
        view.addSubviews(timerPickerView, cancelButton, startButton)
        setConstaints()
    }
    
    // округление изображения
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        startButton.layer.cornerRadius = startButton.frame.height / 2
        cancelButton.clipsToBounds = true
        startButton.clipsToBounds = true
    }
    
    func setConstaints() {
        setPickerViewConstrains()
        setButtonConstrains(button: cancelButton, view.leadingAnchor, constant: 20)
        setButtonConstrains(button: startButton, view.trailingAnchor, constant: -20)
        
        
    }
    
    func setPickerViewConstrains() {
        timerPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerPickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    }
    
    func setButtonConstrains(button: UIButton,_ horizontalAnchor: NSLayoutXAxisAnchor, constant: CGFloat) {
        if horizontalAnchor == view.leadingAnchor {
            button.leadingAnchor.constraint(equalTo: horizontalAnchor, constant: constant).isActive = true
        } else {
            button.trailingAnchor.constraint(equalTo: horizontalAnchor, constant: constant).isActive = true
        }
        button.topAnchor.constraint(equalTo: timerPickerView.bottomAnchor, constant: view.bounds.height / 7.5).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true

    }
}

extension TimerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 0
        }
    }
}

extension TimerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if row == pickerView.selectedRow(inComponent: 0) {
                return "\(row) ч"
            }
            return "\(row)"
        case 1:
            if row == pickerView.selectedRow(inComponent: 1) {
                return "\(row) мин"
            }
            return "\(row)"
        case 2:
            if row == pickerView.selectedRow(inComponent: 2) {
                return "\(row) с"
            }
            return "\(row)"
        default:
            return ""
        }
    }
    
    // при выборе row,
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(component)
    }
}
