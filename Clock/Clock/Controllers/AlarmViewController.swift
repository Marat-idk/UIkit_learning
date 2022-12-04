//
//  AlarmViewController.swift
//  Clock
//
//  Created by Marat on 31.10.2022.
//

import UIKit

class AlarmViewController: UIViewController {
    
    var alarmsTime: [String] = []
    
    lazy var alarmTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SleepAwakeningCell.self, forCellReuseIdentifier: SleepAwakeningCell.identifier)
        tv.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        tv.backgroundColor = .black
        tv.sectionHeaderHeight = 35
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setNavigationItems()
        generateAlarmsTime()
        setAlarmTableView()
    }
    
    func setNavigationItems() {
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: nil, action: nil)
        
        navigationItem.title = tabBarItem.title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    // создаем три будильника по умолчанию
    func generateAlarmsTime() {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.unitsStyle = .positional
        dateComponentFormatter.allowedUnits = [.minute, .hour]
        
        var dateComponents = DateComponents()
        // 10:00, 10:15, 12:008
        let defaultAlarmsTime = [10 * 60 * 60, 10 * 60 * 60 + 15 * 60, 12 * 60 * 60]
        alarmsTime = defaultAlarmsTime.map({ timeInSeconds in
            dateComponents.second = timeInSeconds
            return dateComponentFormatter.string(from: dateComponents)!
        })
//        print(alarmsTime)
    }
    
    func setAlarmTableView() {
        view.addSubview(alarmTableView)
        
        NSLayoutConstraint.activate(
            [
                alarmTableView.topAnchor.constraint(equalTo: view.topAnchor),
                alarmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                alarmTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                alarmTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
        
        alarmTableView.dataSource = self
        alarmTableView.delegate = self

        alarmTableView.estimatedRowHeight = 110
        alarmTableView.rowHeight = UITableView.automaticDimension
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
            
            self.tabBarItem.standardAppearance = appearance
        }
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
}


extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    // для ячеек из секции 1 ширина ячейки будет определяться автоматически
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    // задаем вью для каждого из двух хедеров
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: .zero)
        if section == 0 {
            let imageView = UIImageView(image: UIImage(systemName: "bed.double.fill"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Сон | Пробуждение"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)

            header.addSubviews(imageView, label)
            NSLayoutConstraint.activate(
                [
                    imageView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: view.bounds.width / 41.4),
                    imageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                    imageView.heightAnchor.constraint(equalTo: header.heightAnchor, multiplier: 0.7),
                    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

                    label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2),
                    label.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                    label.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10)
                ]
            )
        } else {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Другие"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 18)
            header.addSubview(label)

            NSLayoutConstraint.activate(
                [
                    label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: view.bounds.width / 41.4),
                    label.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                    label.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10),
                    //label.heightAnchor.constraint(equalTo: header.heightAnchor, multiplier: 0.9)
                ]
            )

        }
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return alarmsTime.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SleepAwakeningCell.identifier, for: indexPath) as! SleepAwakeningCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier, for: indexPath) as! AlarmTableViewCell
            cell.set(timeFor: alarmsTime[indexPath.row], name: AlarmTableViewCell.defaultAlarmName)
            // TODO: Удалить, просто для примера
            if indexPath.row == 1 {
                cell.alarmName.text = "Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник Будильник"
            }
            return cell

        }
    }
}
