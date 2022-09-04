//
//  SecondViewController.swift
//  CafeMario
//
//  Created by Maxim Raskevich on 01.09.2022.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameTextField:   UITextField!
    @IBOutlet weak var guestsTextField: UITextField!
    @IBOutlet weak var tableTextField:  UITextField!
    let swTableSwith = UISwitch()
    let swPrepayment = UISwitch()
    let swVipRoom    = UISwitch()
    let tableOrderedLbl = UILabel()
    let prepaymentLbl   = UILabel()
    let vipRoomLbl      = UILabel()
    var factor = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // изменение радиуса кнопки
        checkBtn.layer.cornerRadius = 7.0
        // добавление заголовка для вью
        title = "Cafe Mario"
        // изменение шрифта заголовка и его размера
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        // изменение навигейшен айтем
        navigationItem.backButtonTitle = "Back"
        
        nameTextField.textFieldSettings(placeHolder: "Введите фио")
        guestsTextField.textFieldSettings(placeHolder: "Введите количество", keyboardType: .decimalPad)
        tableTextField.textFieldSettings(placeHolder: "Номер стола", keyboardType: .decimalPad)
        
        nameTextField.delegate = self
        guestsTextField.delegate = self
        tableTextField.delegate = self
        
        guestsTextField.addDoneButtonToKeyboard(myAction: #selector(self.guestsTextField.resignFirstResponder))
        tableTextField.addDoneButtonToKeyboard(myAction: #selector(self.tableTextField.resignFirstResponder))
        
        // позиционирование и отображение switch
        switchSettings(swTableSwith, posY: tableTextField.frame.origin.y)
        switchSettings(swPrepayment, posY: swTableSwith.frame.origin.y)
        switchSettings(swVipRoom, posY: swPrepayment.frame.origin.y)
        
        swVipRoom.addTarget(self, action: #selector(changeFactor(swTarget:)), for: .valueChanged)
        
        labelSettings(tableOrderedLbl, text: "Бранировали стол?", posY: swTableSwith.frame.origin.y)
        labelSettings(prepaymentLbl, text: "Предоплата?", posY: swPrepayment.frame.origin.y)
        labelSettings(vipRoomLbl, text: "VIP комната?", posY: swVipRoom.frame.origin.y)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    func switchSettings(_ sw: UISwitch, posY: CGFloat) {
        let posX = tableTextField.frame.maxX - tableTextField.frame.origin.x
        sw.frame = CGRect(x: posX, y: posY + 80, width: 0, height: 0)
        self.view.addSubview(sw)
    }
    
    func labelSettings(_ lbl: UILabel, text: String, posY: CGFloat) {
        let posX = tableTextField.frame.origin.x + 10
        lbl.text = text
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .systemPink
        lbl.frame = CGRect(x: posX, y: posY - 10, width: 180, height: 50)
        self.view.addSubview(lbl)
    }
    
    @objc func changeFactor(swTarget: UISwitch) {
        if swTarget.isOn {
            self.factor += 0.2
        } else {
            self.factor -= 0.2
        }
        print("Cost factor = \(self.factor)")
    }
    
    @IBAction func toThirdViewController(_ sender: Any) {
        let alert = UIAlertController(title: "Выставить чек?", message: nil, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let actionOk = UIAlertAction(title: "Чек", style: .default) { _ in
            self.performSegue(withIdentifier: "toThird", sender: nil)
        }
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? ThirdViewController else {
            return
        }
        dvc.totalPrice *= self.factor
    }
}
