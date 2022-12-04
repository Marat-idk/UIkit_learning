//
//  StopwatchLapCell.swift
//  Clock
//
//  Created by Marat on 03.12.2022.
//

import UIKit

class StopwatchLapCell: UITableViewCell {

    static let identifier = "StopwatchLapCellID"
    
    var stopwatchText: String = "00:00,00" {
        didSet {
            stopwatchLabel.text = stopwatchText
        }
    }
    
    let lapNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "Круг"
        lbl.font = .systemFont(ofSize: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var stopwatchLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = stopwatchText
        // monospacedDigitSystemFont нужен чтобы предотвратить шатание текста лейбла
        lbl.font = .monospacedDigitSystemFont(ofSize: 18, weight: .light)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        
        contentView.addSubviews(lapNumberLabel, stopwatchLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        setupLapNumberLabelConstraints()
        setupStopwatchLabelConstaints()
    }
    
    func setupLapNumberLabelConstraints() {
        lapNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        lapNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    func setupStopwatchLabelConstaints() {
        stopwatchLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stopwatchLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
