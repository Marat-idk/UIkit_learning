//
//  SecondViewController.swift
//  CafeMario
//
//  Created by Maxim Raskevich on 01.09.2022.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var guestsTextField: UITextField!
    @IBOutlet weak var tableTextField: UITextField!
    
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
        
        nameTextField.underlined(color: .lightGray)
        guestsTextField.underlined(color: .lightGray)
        tableTextField.underlined(color: .lightGray)
        
        nameTextField.placeholder = "Введите фио"
        guestsTextField.placeholder = "Введите количество"
        guestsTextField.keyboardType = .decimalPad
        tableTextField.placeholder = "Номер стола"
        tableTextField.keyboardType = .decimalPad
        
        nameTextField.delegate = self
        guestsTextField.delegate = self
        tableTextField.delegate = self
        
        guestsTextField.addDoneButtonToKeyboard(myAction: #selector(self.guestsTextField.resignFirstResponder))
        tableTextField.addDoneButtonToKeyboard(myAction: #selector(self.tableTextField.resignFirstResponder))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
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
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
 func addDoneButtonToKeyboard(myAction:Selector?){
    let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

     let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
     let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
}
