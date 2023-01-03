//
//  FourthViewController.swift
//  trafficlight
//
//  Created by Marat on 03.01.2023.
//

import SnapKit
import UIKit

class FourthViewController: UIViewController {
    
    let blackView = ColoredView(with: .black)
    let redView = ColoredView(with: .red)
    let yellowView = ColoredView(with: .yellow)
    let greenView = ColoredView(with: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(blackView)
        blackView.addSubviews(redView, yellowView, greenView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupRedConstraints()
        setupYellowConstraints()
        setupGreenConstraints()
        setupBlackConstraints()
    }
    
    private func setupRedConstraints() {
        redView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
    
    private func setupYellowConstraints() {
        yellowView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(redView.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
    
    private func setupGreenConstraints() {
        greenView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(yellowView.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
    }
    
    private func setupBlackConstraints() {
        blackView.snp.makeConstraints { make in
            make.centerX.equalTo(yellowView)
            make.top.equalTo(redView).offset(-10)
            make.bottom.equalTo(greenView).offset(10)
            make.width.equalTo(yellowView).multipliedBy(1.5)
        }
    }
}
