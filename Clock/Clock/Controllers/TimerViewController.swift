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
        btn.backgroundColor = .secondarySystemFill
        btn.layer.cornerRadius = btn.frame.height / 2
        return btn
    }()
    
    let startButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        timerPickerView.dataSource = self
        timerPickerView.delegate = self
        
        view.addSubviews(timerPickerView, cancelButton)
        setConstaints()
        
        NSLayoutConstraint.activate(
            [
                cancelButton.topAnchor.constraint(equalTo: timerPickerView.bottomAnchor, constant: 20),
                cancelButton.heightAnchor.constraint(equalToConstant: 80),
                cancelButton.widthAnchor.constraint(equalToConstant: 80),
                cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
    
    // округление изображения
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        cancelButton.clipsToBounds = true
    }
    
    func setConstaints() {
        setPickerViewConstrains()
    }
    
    func setPickerViewConstrains() {
        timerPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
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
