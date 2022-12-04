//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Marat on 31.10.2022.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    private let buttonWidth: CGFloat = 85.0
    private var stopwatch: Timer!
    private var decisecondCounter = 0.00
    private var decisecondLapCounter = 0.00
    private var lapStopwatches: [String] = []
    
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
        btn.setTitleColor(UIColor.inActiveLapButtonTextColor, for: .normal)
        btn.setTitleColor(.darkGray, for: .highlighted)
        btn.backgroundColor = UIColor.inActiveLapButtonBackground
        btn.addTarget(self, action: #selector(lapButtonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let startButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Старт", for: .normal)
        btn.setTitleColor(UIColor.unselectedStartButtonTextColor, for: .normal)
        //btn.setTitleColor(.systemGreen, for: .highlighted)
        btn.backgroundColor = UIColor.unselectedStartButtonBackground
        btn.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let lapsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(StopwatchLapCell.self, forCellReuseIdentifier: StopwatchLapCell.identifier)
        tv.allowsSelection = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        lapsTableView.dataSource = self
        //lapsTableView.delegate = self
        
        view.addSubviews(stopwatchLabel, lapButton, startButton, lapsTableView)
        setupConstaints()
        // добавляем окружности внутри кнопок
        lapButton.addCircle(width: buttonWidth , height: buttonWidth)
        startButton.addCircle(width: buttonWidth, height: buttonWidth)
    }
    
    func setupConstaints() {
        setupStopwatchLabelConstaints()
        setupButtonConstrains(button: lapButton, view.leadingAnchor, constant: 20)
        setupButtonConstrains(button: startButton, view.trailingAnchor, constant: -20)
        setupTableViewConstaints()
    }
    
    func setupStopwatchLabelConstaints() {
        //stopwatchLabel.backgroundColor = .red
        stopwatchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stopwatchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stopwatchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4.48).isActive = true
    }
    
    func setupButtonConstrains(button: UIButton,_ horizontalAnchor: NSLayoutXAxisAnchor, constant: CGFloat) {
        if horizontalAnchor == view.leadingAnchor {
            button.leadingAnchor.constraint(equalTo: horizontalAnchor, constant: constant).isActive = true
        } else {
            button.trailingAnchor.constraint(equalTo: horizontalAnchor, constant: constant).isActive = true
        }
        button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
    }
    
    func setupTableViewConstaints() {
        lapsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lapsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lapsTableView.topAnchor.constraint(equalTo: lapButton.bottomAnchor, constant: 20).isActive = true
        lapsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            // делаем его полностью прозрачным
            appearance.backgroundColor = .clear
            // убираем полоску сверху таббара
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
            
            // тут нужно сделать что-то адекватное
            self.tabBarController?.tabBar.standardAppearance = appearance
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
            self.tabBarItem.standardAppearance = appearance
            self.tabBarItem.scrollEdgeAppearance = appearance
        }
    }
    
    // округление кнопок
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lapButton.layer.cornerRadius = lapButton.frame.height / 2
        startButton.layer.cornerRadius = startButton.frame.height / 2
        lapButton.clipsToBounds = true
        startButton.clipsToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // устанавливаем вид таббара на дефолтный
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            // делаем его полностью прозрачным
            appearance.backgroundColor = .clear
            // убираем полоску сверху таббара
            appearance.shadowImage = nil
            appearance.shadowColor = nil

            // меняем глобально таббар
            self.tabBarController?.tabBar.standardAppearance = appearance
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    @objc func lapButtonTapped(_ button: UIButton) {
        if !startButton.isSelected {
            if decisecondCounter == 0 {
                return
            } else {
                // сброс всех секундомеров и установка кнопки lap в исходные настройки
                decisecondCounter = 0
                decisecondLapCounter = 0
                stopwatchText = "00:00,00"
                lapStopwatches.removeAll()
                lapsTableView.reloadData()
                lapButton.setTitleColor(UIColor.inActiveLapButtonTextColor, for: .normal)
                lapButton.backgroundColor = UIColor.inActiveLapButtonBackground
            }
        } else {
            // добавление ячейки с интервалами в тэйбл вью
            lapStopwatches.append(getTimerText(decisecondLapCounter))
            decisecondLapCounter = 0.00
            lapsTableView.beginUpdates()
            lapsTableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
            lapsTableView.endUpdates()

        }
    }
    
    @objc func startButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setTitle("Стоп", for: .normal)
            button.setTitleColor(UIColor.selectedStartButtonTextColor, for: .normal)
            button.backgroundColor = UIColor.selectedStartButtonBackground
            stopwatch = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            // чтобы таймер не останавливался при прокрутке скролвью
            // подробнее: https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
            RunLoop.current.add(stopwatch, forMode: .common)
            lapButton.setTitle("Круг", for: .normal)
        } else {
            button.setTitle("Старт", for: .normal)
            button.setTitleColor(UIColor.unselectedStartButtonTextColor, for: .normal)
            button.backgroundColor = UIColor.unselectedStartButtonBackground
            // остановка таймера
            stopwatch.invalidate()
            if(decisecondCounter != 0) {
                lapButton.setTitle("Сброс", for: .normal)
            }
        }
        lapButton.setTitleColor(UIColor.activeLapButtonTextColor, for: .normal)
        lapButton.backgroundColor = UIColor.activeLapButtonBackground
    }
    
    // обновление таймера, подсчет времени и изменение текста лейбла
    @objc func updateTimer(_ timer: Timer) {
        decisecondCounter += 0.01
        decisecondLapCounter += 0.01
        
        stopwatchText = getTimerText(decisecondCounter)
    }
    
    private func getTimerText(_ decisecondCounter: Double) -> String {
        let timeInSeconds = Int(decisecondCounter)
        let minutes = timeInSeconds % 3600 / 60
        let seconds = timeInSeconds % 60
        let deciseconds = decisecondCounter - Double(timeInSeconds)
    
        let minunesStr = String(format: "%02d", minutes)
        let secondsStr = String(format: "%02d", seconds)
        let decisecondsStr = String(format: "%.2f", deciseconds).components(separatedBy: ".").last ?? "00"
        return "\(minunesStr):\(secondsStr),\(decisecondsStr)"
    }
}

extension StopwatchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapStopwatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopwatchLapCell.identifier, for: indexPath) as! StopwatchLapCell
        
        cell.lapNumberLabel.text = "Круг \(lapStopwatches.count)"
        cell.stopwatchText = lapStopwatches.last ?? stopwatchText
        
        return cell
    }
}
