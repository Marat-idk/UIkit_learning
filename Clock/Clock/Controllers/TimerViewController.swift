//
//  ViewController.swift
//  Clock
//
//  Created by Marat on 31.10.2022.
//

import UIKit

class TimerViewController: UIViewController {
    
    private let buttonWidth: CGFloat = 85.0
    
    let timerPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Отмена", for: .normal)
        btn.setTitleColor(UIColor.inActiveLapButtonTextColor, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        btn.backgroundColor = UIColor.inActiveLapButtonBackground
        return btn
    }()
    
    let startButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Старт", for: .normal)
        btn.setTitleColor(UIColor.unselectedStartButtonTextColor, for: .normal)
        btn.setTitleColor(.green, for: .highlighted)
        btn.backgroundColor = UIColor.unselectedStartButtonBackground

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        timerPickerView.dataSource = self
        timerPickerView.delegate = self
        
        view.addSubviews(timerPickerView, cancelButton, startButton)
        setConstaints()
        // добавляем окружности внутри кнопок
        cancelButton.addCircle(width: buttonWidth , height: buttonWidth)
        startButton.addCircle(width: buttonWidth, height: buttonWidth)
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
        button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
    }
    
    // округление кнопок
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        startButton.layer.cornerRadius = startButton.frame.height / 2
        cancelButton.clipsToBounds = true
        startButton.clipsToBounds = true
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
    
    // при выборе row, перезагружаем пикер
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(component)
    }
}
