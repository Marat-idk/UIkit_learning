//
//  ViewController.swift
//  Alert
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sumButton(_ sender: Any) {
        self.hiLabel.text = "Привет"
        self.hiLabel.lineBreakMode = .byWordWrapping
        self.hiLabel.numberOfLines = 0
        
        alertSum(title: "Сложение", message: "Пожалуйста, введите два числа",
                  style: .alert)
    }
    
    func alertSum(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionOk = UIAlertAction(title: "Сложить", style: .default) { action in
            let firstValue = Int((alert.textFields?[0].text)!)
            let secondValue = Int((alert.textFields?[1].text)!)
            if let a = firstValue, let b = secondValue {
                self.hiLabel.text! = String("\(a) + \(b) = \(a + b)")
            } else {
                self.hiLabel.text! = "Не все числа были введены"
            }
            
        }
        
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Первое число"
        }
        
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Второе число"
        }
        
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Showing play button
    @IBAction func showPlayButton(_ sender: Any) {
        
        self.hiLabel.text = "Привет"
        //self.hiLabel.lineBreakMode = .byWordWrapping
        self.hiLabel.numberOfLines = 0
        
        alertGame(title: "Угадай число", message: "Было загадано число от 0 до 10\nПопробуй отгадать",
                  style: .alert)
    }
    // MARK: alert for number guess game
    func alertGame(title: String, message: String, style: UIAlertController.Style){
        let numberToGuess = Int.random(in: 0...10)
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionSend = UIAlertAction(title: "Отправить", style: .default) { action in
            let number = alert.textFields?.first?.text!
            if let number = Int(number!) {
                self.hiLabel.text! += number == numberToGuess ? ", ты победил" :  ", ты проиграл, я загадал \(numberToGuess)"
            } else {
                self.hiLabel.text! += ", ты проиграл, я загадал \(numberToGuess)"
            }
        }
        
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
            print("Guessed number is \(numberToGuess)")
            print("TextFiled was appeared")
        }
        
        alert.addAction(actionSend)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hiLabel.text = "Привет"
        self.hiLabel.lineBreakMode = .byWordWrapping
        self.hiLabel.numberOfLines = 0
        alert(title: "Внимание", message: "Введите ваше имя", style: .alert)
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionOk = UIAlertAction(title: "Ок", style: .default) { action in
            let name = alert.textFields?.first?.text
            if !(name!.isEmpty) {
                self.hiLabel.text! += ", \(name!)"
            }
            print("Ok was tapped")
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { action in
            print("Cancel was tapped")
        }
        
        alert.addTextField { textField in
            print("TextFiled was appeared")
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
}
