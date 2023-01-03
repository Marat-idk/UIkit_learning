//
//  SecondViewController.swift
//  trafficlight
//
//  Created by Marat on 02.01.2023.
//

import UIKit

// Auto-layout by NSLayoutConstraint
class SecondViewController: UIViewController {

    let blackView = ColoredView(with: .black)
    let redView = ColoredView(with: .red)
    let yellowView = ColoredView(with: .yellow)
    let greenView = ColoredView(with: .green)
    
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.lightGray, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubviews(blackView, nextButton)
        blackView.addSubviews(redView, yellowView, greenView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupRedConstraints()
        setupYellowConstraints()
        setupGreenConstraints()
        setupBlackConstraints()
        setupNextButtonConstraints()
    }
    
    private func setupRedConstraints() {
        // нужно для работы констрейнтов
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
                        item: redView,
                        attribute: .centerX,
                        relatedBy: .equal,
                        toItem: view,
                        attribute: .centerX,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: redView,
                        attribute: .top,
                        relatedBy: .lessThanOrEqual,
                        toItem: view.safeAreaLayoutGuide,
                        attribute: .top,
                        multiplier: 1,
                        constant: 10)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: redView,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 80)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: redView,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 80)
                        .isActive = true
    }
    
    private func setupYellowConstraints() {
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
                        item: yellowView,
                        attribute: .centerX,
                        relatedBy: .equal,
                        toItem: view,
                        attribute: .centerX,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: yellowView,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: redView,
                        attribute: .bottom,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: yellowView,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 80)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: yellowView,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 80)
                        .isActive = true
    }
    
    private func setupGreenConstraints() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
                        item: greenView,
                        attribute: .centerX,
                        relatedBy: .equal,
                        toItem: view,
                        attribute: .centerX,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: greenView,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: yellowView,
                        attribute: .bottom,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: greenView,
                        attribute: .bottom,
                        relatedBy: .lessThanOrEqual,
                        toItem: view.safeAreaLayoutGuide,
                        attribute: .bottom,
                        multiplier: 1,
                        constant: -10)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: greenView,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 80)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: greenView,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 80)
                        .isActive = true
    }
    
    private func setupBlackConstraints() {
        blackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
                        item: blackView,
                        attribute: .centerX,
                        relatedBy: .equal,
                        toItem: yellowView,
                        attribute: .centerX,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: blackView,
                        attribute: .top,
                        relatedBy: .equal,
                        toItem: redView,
                        attribute: .top,
                        multiplier: 1,
                        constant: -10)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: blackView,
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: greenView,
                        attribute: .bottom,
                        multiplier: 1,
                        constant: 10)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: blackView,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: yellowView,
                        attribute: .width,
                        multiplier: 1.5,
                        constant: 0)
                        .isActive = true
    }
    
    private func setupNextButtonConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
                        item: nextButton,
                        attribute: .centerY,
                        relatedBy: .equal,
                        toItem: blackView,
                        attribute: .centerY,
                        multiplier: 1,
                        constant: 0)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: nextButton,
                        attribute: .trailing,
                        relatedBy: .equal,
                        toItem: view.safeAreaLayoutGuide,
                        attribute: .trailing,
                        multiplier: 1,
                        constant: -10)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: nextButton,
                        attribute: .leading,
                        relatedBy: .equal,
                        toItem: blackView,
                        attribute: .trailing,
                        multiplier: 1,
                        constant: 10)
                        .isActive = true
        
        NSLayoutConstraint(
                        item: nextButton,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .notAnAttribute,
                        multiplier: 0,
                        constant: 50)
                        .isActive = true
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        let vc = ThirdViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
