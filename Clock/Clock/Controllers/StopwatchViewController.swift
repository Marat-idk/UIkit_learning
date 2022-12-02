//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Maraton 31.10.2022.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    private let buttonWidth: CGFloat = 85.0
    private var stopwatch: Timer!
    private var decisecondCounter = 0.00
    
    private var stopwatchText: String = "00:00,00" {
        didSet {
            stopwatchLabel.text = stopwatchText
        }
    }
    
    private lazy var stopwatchLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = stopwatchText
        // monospacedDigitSystemFont нужен чтобы предотвратить шатание текста лейбла
        lbl.font = .monospacedDigitSystemFont(ofSize: 90, weight: .light)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    private let lapButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Круг", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.backgroundColor = .secondarySystemFill
        return btn
    }()
    
    private let startButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Старт", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.backgroundColor = UIColor(red: 23 / 255, green: 55 / 255, blue: 26 / 255, alpha: 1)
        btn.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews(stopwatchLabel, lapButton, startButton)
        setConstaints()
        lapButton.addCircle(width: buttonWidth , height: buttonWidth)
        startButton.addCircle(width: buttonWidth, height: buttonWidth)
    }
    
    func setConstaints() {
        setupStopwatchLabelConstaints()
        setButtonConstrains(button: lapButton, view.leadingAnchor, constant: 20)
        setButtonConstrains(button: startButton, view.trailingAnchor, constant: -20)
    }
    
    func setupStopwatchLabelConstaints() {
        //stopwatchLabel.backgroundColor = .red
        stopwatchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stopwatchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stopwatchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4.48).isActive = true
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
        lapButton.layer.cornerRadius = lapButton.frame.height / 2
        startButton.layer.cornerRadius = startButton.frame.height / 2
        lapButton.clipsToBounds = true
        startButton.clipsToBounds = true
    }
    
    @objc func startButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setTitle("Стоп", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.backgroundColor = .systemRed
            stopwatch = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
        } else {
            button.setTitle("Старт", for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.backgroundColor = UIColor(red: 23 / 255, green: 55 / 255, blue: 26 / 255, alpha: 1)
            stopwatch.invalidate()
        }
    }
    
    @objc func updateTimer(_ timer: Timer) {
        decisecondCounter += 0.01
        
        let timeInSeconds = Int(decisecondCounter)
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        let deciseconds = decisecondCounter - Double(timeInSeconds)
    
        let minunesStr = String(format: "%02d", minutes)
        let secondsStr = String(format: "%02d", seconds)
        let decisecondsStr = String(format: "%.2f", deciseconds).components(separatedBy: ".").last ?? "00"
        
        stopwatchText = "\(minunesStr):\(secondsStr).\(decisecondsStr)"
    }
    
}
