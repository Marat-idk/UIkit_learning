//
//  ThirdViewController.swift
//  trafficlight
//
//  Created by Marat on 02.01.2023.
//

import UIKit

class ThirdViewController: UIViewController {
    
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
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupYellowConstraints() {
        yellowView.translatesAutoresizingMaskIntoConstraints = false

        yellowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yellowView.topAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
        yellowView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        yellowView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }

    private func setupGreenConstraints() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor).isActive = true
        greenView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupBlackConstraints() {
        blackView.translatesAutoresizingMaskIntoConstraints = false
        
        blackView.centerXAnchor.constraint(equalTo: yellowView.centerXAnchor).isActive = true
        blackView.topAnchor.constraint(equalTo: redView.topAnchor, constant: -10).isActive = true
        blackView.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 10).isActive = true
        blackView.widthAnchor.constraint(equalTo: yellowView.widthAnchor, multiplier: 1.5).isActive = true
    }

}
