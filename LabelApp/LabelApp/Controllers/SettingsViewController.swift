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
    var lineBreakMode = NSLineBreakMode.byTruncatingTail
    
    var lineBreakModes: [NSLineBreakMode] = [.byWordWrapping, .byCharWrapping, .byClipping,
                                             .byTruncatingHead, .byTruncatingTail, .byTruncatingMiddle]
    
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
    
    let lineBreakModeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Linebreak mode"
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 28)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let lineBreakModePicker: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.tag = 2
        return pv
    }()
    
    let lineBreakModeTextField: UITextField = {
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
    
    let shadowLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Shadow"
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 28)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let shadowSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(shadowSwitchAction(_:)), for: .valueChanged)
        return sw
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
    
    let plusImageView: UIImageView = {
        let img = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        let imgv = UIImageView(image: img)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.tintColor = .orange
        return imgv
    }()
    
    let minusImageView: UIImageView = {
        let img = UIImage(
            systemName: "minus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        let imgv = UIImageView(image: img)
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.tintColor = .orange
        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // для числа компонент и числа строк в каждой из них
        colorPicker.dataSource = self
        numOfLinesPicker.dataSource = self
        lineBreakModePicker.dataSource = self
        // для названия компонент
        colorPicker.delegate = self
        numOfLinesPicker.delegate = self
        lineBreakModePicker.delegate = self
        
        view.addSubviews(
            colorLabel, colorTextField,
            numberOfLinesLabel, numOfLinesTextField,
            lineBreakModeLabel, lineBreakModeTextField,
            shadowLabel, shadowSwitch,
            minusImageView, plusImageView, fontSizeSlider
        )
        setupPickerView(picker: colorPicker, textField: colorTextField)
        setupPickerView(picker: numOfLinesPicker, textField: numOfLinesTextField)
        setupPickerView(picker: lineBreakModePicker, textField: lineBreakModeTextField)
        setConstraints()
        
        // устанавливаем значения по умолчанию для пикеров
        numOfLinesPicker.selectRow(1, inComponent: 0, animated: true)
        lineBreakModePicker.selectRow(lineBreakModes.firstIndex(of: .byTruncatingTail) ?? 0, inComponent: 0, animated: true)
    }
    
    func setupPickerView(picker: UIPickerView, textField: UITextField) {
        if textField == colorTextField {
            textField.text = labelColor.name
        } else if textField == numOfLinesTextField {
            textField.text = String(labelNumberOfLines)
        } else if textField == lineBreakModeTextField {
            textField.text = getLineBreakModeString(mode: .byTruncatingTail)
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
        // set constrains for labels
        setupLabelConstrains(element: colorLabel, anotherView: view, constant: 30)
        setupLabelConstrains(element: numberOfLinesLabel, anotherView: colorLabel, constant: 60)
        setupLabelConstrains(element: lineBreakModeLabel, anotherView: numberOfLinesLabel, constant: 60)
        setupLabelConstrains(element: shadowLabel, anotherView: lineBreakModeLabel, constant: 60)
        // set constrains for pickers
        setupPickerConstrains(element: colorTextField, equalTo: colorLabel)
        setupPickerConstrains(element: numOfLinesTextField, equalTo: numberOfLinesLabel)
        setupPickerConstrains(element: lineBreakModeTextField, equalTo: lineBreakModeLabel)
        setupSwitch()
        setupSliderConstrains()
    }
    
    func setupLabelConstrains(element: UIView, anotherView: UIView, constant: CGFloat) {
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
    
    func setupSwitch() {
        shadowSwitch.topAnchor.constraint(equalTo: lineBreakModeLabel.bottomAnchor, constant: 30).isActive = true
        shadowSwitch.centerXAnchor.constraint(equalTo: lineBreakModeTextField.centerXAnchor).isActive = true
    }
    
    func setupSliderConstrains() {
        minusImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        minusImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        minusImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        minusImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        plusImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        plusImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        plusImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        plusImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true

        
        fontSizeSlider.bottomAnchor.constraint(equalTo: minusImageView.bottomAnchor).isActive = true
        fontSizeSlider.leadingAnchor.constraint(equalTo: minusImageView.trailingAnchor, constant: 20).isActive = true
        fontSizeSlider.trailingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -20).isActive = true
    }
    
    @objc func done(_ button: UIBarButtonItem) {
        switch button.tag {
        case 0:
            labelColor = color
            colorTextField.text = labelColor.name
        case 1:
            labelNumberOfLines = numberOfLines
            numOfLinesTextField.text = String(labelNumberOfLines)
        case 2:
            labelLineBreakMode = lineBreakMode
            lineBreakModeTextField.text = getLineBreakModeString(mode: labelLineBreakMode)
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
        case 2:
            lineBreakModeTextField.text = getLineBreakModeString(mode: labelLineBreakMode)
        default:
            break
        }
        self.view.endEditing(true)
    }
    
    @objc func shadowSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            labelShadowOffSet = CGSize(width: 2, height: 2)
        } else {
            labelShadowOffSet = CGSize(width: 0, height: 0)
        }
    }
    
    @objc func sliderAction() {
        labelFontSize = CGFloat(fontSizeSlider.value)
    }
    
    func getLineBreakModeString(mode: NSLineBreakMode) -> String {
        switch mode {
        case .byWordWrapping:
            return "byWordWrapping"
        case .byCharWrapping:
            return "byCharWrapping"
        case .byClipping:
            return "byClipping"
        case .byTruncatingHead:
            return "byTruncatingHead"
        case .byTruncatingTail:
            return "byTruncatingTail"
        case .byTruncatingMiddle:
            return "byTruncatingMiddle"
        default:
            return "unknown"
        }
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
        case 2:
            return lineBreakModes.count
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
        case 2:
            return getLineBreakModeString(mode: lineBreakModes[row])
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
        case 2:
            lineBreakMode = NSLineBreakMode(rawValue: row) ?? .byTruncatingTail
            lineBreakModeTextField.text = getLineBreakModeString(mode: lineBreakMode)
        default:
            break
        }
    }
}
