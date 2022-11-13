//
//  AlarmTableViewCell.swift
//  Clock
//
//  Created by Marat on 04.11.2022.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmTableViewCellID"
    static let defaultAlarmName = "Будильник"
    
    var alarmTime = UILabel()
    var alarmName = UILabel()
    var alarmSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(turnSwitch(_:)), for: .valueChanged)
        return sw
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        
        contentView.addSubviews(alarmTime, alarmName, alarmSwitch)
        configuraLabels()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(timeFor alarm: String, name: String) {
        alarmTime.text = alarm
        alarmName.text = name
    }
    
    func configuraLabels() {
        alarmTime.font = .systemFont(ofSize: 60, weight: .light)
        alarmTime.textAlignment = .left
        alarmTime.textColor = .systemGray
        alarmTime.adjustsFontSizeToFitWidth = true
        alarmTime.numberOfLines = 0
        
        
        alarmName.font = .systemFont(ofSize: 16)
        alarmName.textAlignment = .left
        alarmName.textColor = .systemGray
        alarmName.numberOfLines = 0
    }
    
    func setupConstraints() {
        setupAlarmTimeLabel()
        setupAlarmNameLabel()
        setupAlarmSwitch()
    }
    
    func setupAlarmTimeLabel() {
        alarmTime.translatesAutoresizingMaskIntoConstraints = false
        alarmTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        alarmTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    }
    
    func setupAlarmNameLabel() {
        alarmName.translatesAutoresizingMaskIntoConstraints = false
        alarmName.topAnchor.constraint(equalTo: alarmTime.bottomAnchor).isActive = true
        alarmName.leadingAnchor.constraint(equalTo: alarmTime.leadingAnchor).isActive = true
        alarmName.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -80).isActive = true
        alarmName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setupAlarmSwitch() {
        alarmSwitch.topAnchor.constraint(equalTo: alarmTime.topAnchor, constant: 25).isActive = true
        alarmSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
    }

    @objc func turnSwitch(_ sender: UISwitch) {
        if sender.isOn {
            alarmTime.textColor = .white
            alarmName.textColor = .white
        } else {
            alarmTime.textColor = .systemGray
            alarmName.textColor = .systemGray
        }
    }
}

class SleepAwakeningCell: UITableViewCell {
    
    static let identifier = "SleepAwakeningCellID"
    
    var alarmText = "Нет будильника" {
        didSet {
            alarmLabel.text = alarmText
        }
    }
    
    lazy var alarmLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = alarmText
        lbl.textColor = .systemGray
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let settingButton: CustomUIButton = {
        let btn = CustomUIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("НАСТРОИТЬ", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        btn.backgroundColor = .secondarySystemFill
        btn.layer.cornerRadius = 14.0
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview(alarmLabel)
        contentView.addSubview(settingButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupConstraints() {
        setupAlarmLabelConstraints()
        setupSettingButtonConstraints()
    }
    
    func setupAlarmLabelConstraints() {
        alarmLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        alarmLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        alarmLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        alarmLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupSettingButtonConstraints() {
        settingButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

class CustomUIButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .systemFill: .secondarySystemFill
        }
    }
}
