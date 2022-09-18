//
//  ThirdViewController.swift
//  BirthdayReminder
//
//  Created by Marat on 14.09.2022.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {
    weak var secondVCDelegate: SecondVCDelegate?
    var name: String?
    var birthday: Date?
    var age: Int?
    var sex: Sex?
    var instNickname: String?
    
    // изображение аватарки
    let avatar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "avatar")
        img.backgroundColor = .systemGray5
        return img
    }()
    
    let changeImgBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Изменить фото", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(UIColor(red: 216/255, green: 234/255, blue: 254/255, alpha: 1), for: .highlighted)
        return button
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Имя"
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите имя"
        tf.underlined(color: .lightGray)
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Дата"
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите дату"
        tf.underlined(color: .lightGray)
        return tf
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        return dp
    }()
    
    let ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Возраст"
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Добавить"
        tf.underlined(color: .lightGray)
        return tf
    }()
    
    let agePicker: UIPickerView = {
        let pv = UIPickerView()
        pv.tag = 0
        return pv
    }()
    
    let sexLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Пол"
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let sexTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Добавить"
        tf.underlined(color: .lightGray)
        return tf
    }()
    
    let sexPicker: UIPickerView = {
        let pv = UIPickerView()
        pv.tag = 1
        return pv
    }()
    
    let instLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Instagram"
        lbl.textColor = UIColor(red: 140/255, green: 161/255, blue: 206/255, alpha: 1)
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let instaTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Добавить"
        tf.underlined(color: .lightGray)
        tf.addTarget(self, action: #selector(showAlert), for: .allEditingEvents)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        nameTextField.delegate = self
        // для числа компонент и числа строк в каждой из них
        agePicker.dataSource = self
        sexPicker.dataSource = self
        // для названия компонент
        agePicker.delegate = self
        sexPicker.delegate = self
        
        self.view.addSubview(avatar)
        self.view.addSubview(changeImgBtn)
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameTextField)
        self.view.addSubview(dateLabel)
        self.view.addSubview(dateTextField)
        settingDatePicker(picker: datePicker, pickerTextField: dateTextField)
        self.view.addSubview(ageLabel)
        self.view.addSubview(ageTextField)
        settingPicker(picker: agePicker, pickerTextField: ageTextField)
        self.view.addSubview(sexLabel)
        self.view.addSubview(sexTextField)
        settingPicker(picker: sexPicker, pickerTextField: sexTextField)
        self.view.addSubview(instLabel)
        self.view.addSubview(instaTextField)
        
        setupNavigationController()
        setupAvatar()
    
        setupChangeImgBtn()
        setupNameLabel()
        setupInfoViews(element: nameTextField, equalTo: nameLabel, topConst: 0, heightConst: 40, widthConst: nil, widtdMultiplier: 0.75)
        setupInfoViews(element: dateLabel, equalTo: nameTextField, topConst: 20, heightConst: 25, widthConst: 40)
        setupInfoViews(element: dateTextField, equalTo: dateLabel, topConst: 0, heightConst: 40, widthConst: nil, widtdMultiplier: 0.75)
        setupInfoViews(element: ageLabel, equalTo: dateTextField, topConst: 20, heightConst: 25, widthConst: 70)
        setupInfoViews(element: ageTextField, equalTo: ageLabel, topConst: 0, heightConst: 40, widthConst: nil, widtdMultiplier: 0.75)
        setupInfoViews(element: sexLabel, equalTo: ageTextField, topConst: 20, heightConst: 25, widthConst: 35)
        setupInfoViews(element: sexTextField, equalTo: sexLabel, topConst: 0, heightConst: 40, widthConst: nil, widtdMultiplier: 0.75)
        setupInfoViews(element: instLabel, equalTo: sexTextField, topConst: 20, heightConst: 25, widthConst: 80)
        setupInfoViews(element: instaTextField, equalTo: instLabel, topConst: 0, heightConst: 40, widthConst: nil, widtdMultiplier: 0.75)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func setupNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(doneButton(_:)))    }
    
    @objc func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButton(_ sender: Any) {
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Внимание", message: "Заполните поле с именем", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
            return
        }
        name = nameTextField.text!
        birthday = datePicker.date
        age = Int(ageTextField.text!)
        sex = Sex(rawValue: sexTextField.text!)
        instNickname = instaTextField.text
        secondVCDelegate?.update(person: Person(name: name!, birthday: birthday ?? Date(), age: age ?? 0, sex: sex ?? .man, instNickname: instNickname ?? "None"))
        dismiss(animated: true, completion: nil)
    }
    
    func setupAvatar() {
        avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor).isActive = true
    }
    
    func setupChangeImgBtn() {
        changeImgBtn.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10).isActive = true
        changeImgBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeImgBtn.widthAnchor.constraint(equalToConstant: 130).isActive = true
        changeImgBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: changeImgBtn.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: view.leadingAnchor, multiplier: 6).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupInfoViews(element: UIView, equalTo someView: UIView, topConst: CGFloat, heightConst: CGFloat, widthConst: CGFloat? = nil, widtdMultiplier: CGFloat? = nil) {
        element.topAnchor.constraint(equalTo: someView.bottomAnchor, constant: topConst).isActive = true
        element.leadingAnchor.constraint(equalTo: someView.leadingAnchor).isActive = true
        element.heightAnchor.constraint(equalToConstant: heightConst).isActive = true
        if let multi = widtdMultiplier {
            element.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multi).isActive = true
        } else if let widthConst = widthConst {
            element.widthAnchor.constraint(equalToConstant: widthConst).isActive = true
        }
    }
    
    // округление изображения
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatar.setRounded()
    }
    
    // добавление тулбара к пикерам
    func settingDatePicker(picker: UIView, pickerTextField: UITextField) {
        if picker is UIDatePicker {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            // done button & cancel button
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker(_:)))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            // add toolbar to textField
            pickerTextField.inputAccessoryView = toolbar
            // add datepicker to textField
            pickerTextField.inputView = datePicker
        }
    }
    
    func settingPicker(picker: UIView, pickerTextField: UITextField) {
        if picker is UIPickerView {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
            toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
            pickerTextField.inputAccessoryView = toolbar
            pickerTextField.inputView = picker
        }
    }
    
    // done батн для дата пикера
    @objc func doneDatePicker(_ sender: UIDatePicker){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        dateTextField.text! = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    // done батн для пикера
    @objc func donePicker(_ sender: UIPickerView) {
        self.view.endEditing(true)
    }
    
    // cancel батн для пикера
    @objc func cancelPicker() {
        // убрать пикер по кнопке cancel
        self.view.endEditing(true)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Введите username Instagram", message: nil, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            self.instaTextField.text = alert.textFields?.first?.text!
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Например yashalava2019"
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
    }
}


extension ThirdViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return 100
        case 1:
            return Sex.allCases.count
        default:
            return 1
        }
    }
}

extension ThirdViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return String(row + 1)
        case 1:
            return Sex(value: row)?.rawValue
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            ageTextField.text = String(row + 1)
        case 1:
            sexTextField.text = Sex(value: row)?.rawValue
        default:
            break
        }
    }
}
