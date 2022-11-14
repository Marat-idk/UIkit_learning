//
//  SettingsViewController.swift
//  LabelApp
//
//  Created by Marat on 13.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var color = labelColor
    var numberOfLines = labelNumberOfLines
    
    let colorLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Color"
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 28)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let colorPicker: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.tag = 0
        return pv
    }()
    
    let colorTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 6.0
        tf.font = .systemFont(ofSize: 24)
        // disable input blinking cursor
        tf.tintColor = .clear
        return tf
    }()

    let numberOfLinesLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Number of lines"
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 28)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let numOfLinesPicker: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.tag = 1
        return pv
    }()
    
    let numOfLinesTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 6.0
        tf.font = .systemFont(ofSize: 24)
        // disable input blinking cursor
        tf.tintColor = .clear
        return tf
    }()
    
    let fontSizeSlider: UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.minimumValue = 0
        sl.maximumValue = 200
        sl.minimumTrackTintColor = .orange
        sl.value = Float(labelFontSize)
        sl.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        return sl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // для числа компонент и числа строк в каждой из них
        colorPicker.dataSource = self
        numOfLinesPicker.dataSource = self
        // для названия компонент
        colorPicker.delegate = self
        numOfLinesPicker.delegate = self
        
        view.addSubviews(
            colorLabel, colorTextField,
            numberOfLinesLabel, numOfLinesTextField,
            fontSizeSlider
        )
        setupPickerView(picker: colorPicker, textField: colorTextField)
        setupPickerView(picker: numOfLinesPicker, textField: numOfLinesTextField)
        setConstraints()
    }
    
    func setupPickerView(picker: UIPickerView, textField: UITextField) {
        if textField == colorTextField {
            textField.text = labelColor.name
        } else if textField == numOfLinesTextField {
            textField.text = String(labelNumberOfLines)
        }
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(_:)))
        cancelButton.tag = picker.tag
        doneButton.tag = picker.tag
        
        toolbar.setItems([cancelButton, space, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        textField.inputView = picker
    }
    
    func setConstraints() {
        setupColorLabelConstrains(element: colorLabel, anotherView: view, constant: 30)
        setupColorLabelConstrains(element: numberOfLinesLabel, anotherView: colorLabel, constant: 60)
        setupPickerConstrains(element: colorTextField, equalTo: colorLabel)
        setupPickerConstrains(element: numOfLinesTextField, equalTo: numberOfLinesLabel)
        setupSliderConstrains()
    }
    
    func setupColorLabelConstrains(element: UIView, anotherView: UIView, constant: CGFloat) {
        element.backgroundColor = .cyan
        element.topAnchor.constraint(equalTo: anotherView.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
        element.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        element.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width / 2.5).isActive = true
    }
    
    func setupPickerConstrains(element: UIView, equalTo: UIView) {
        element.topAnchor.constraint(equalTo: equalTo.topAnchor).isActive = true
        element.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        element.widthAnchor.constraint(equalToConstant: 100).isActive = true
        element.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupSliderConstrains() {
        fontSizeSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        fontSizeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fontSizeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func done(_ button: UIBarButtonItem) {
        switch button.tag {
        case 0:
            labelColor = color
            colorTextField.text = labelColor.name
        case 1:
            labelNumberOfLines = numberOfLines
            numOfLinesTextField.text = String(labelNumberOfLines)
        default:
            break
        }
        self.view.endEditing(true)
    }
    
    @objc func cancel(_ button: UIBarButtonItem) {
        switch button.tag {
        case 0:
            colorTextField.text = labelColor.name
        case 1:
            numOfLinesTextField.text = String(labelNumberOfLines)
        default:
            break
        }
        self.view.endEditing(true)
    }
    
    @objc func sliderAction() {
        labelFontSize = CGFloat(fontSizeSlider.value)
    }
    
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return UIColor.colors.count
        case 1:
            return 10
        default:
            return 0
        }
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return UIColor.colors[row].name ?? "unknown"
        case 1:
            return String(row)
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            color = UIColor.colors[row]
            colorTextField.text = color.name
        case 1:
            numberOfLines = row
            numOfLinesTextField.text = String(numberOfLines)
        default:
            break
        }
    }
}
