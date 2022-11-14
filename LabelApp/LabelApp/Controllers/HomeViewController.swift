//
//  ViewController.swift
//  LabelApp
//
//  Created by Marat on 13.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var labelText: String = "Привет" {
        didSet {
            label.text = labelText
        }
    }
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = labelText
        lbl.textColor = labelColor
        lbl.font = .systemFont(ofSize: labelFontSize)
        lbl.textAlignment = .center
        lbl.numberOfLines = labelNumberOfLines
        lbl.layer.borderWidth = 1.0
        lbl.layer.cornerRadius = 7.0
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        setNavigationController()
        setLabelConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelSettings()
    }
    
    func setNavigationController() {
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert(_:)))
        
        navigationItem.title = tabBarItem.title
    }
    
    func setLabelConstrains() {
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func showAlert(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Введите текст для лейбла", message: nil, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ок", style: .default) { [weak self] action in
            guard let text = alert.textFields?.first?.text else { return }
            if !text.isEmpty {
                self?.labelText = text
            }
        }
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
    }

    func updateLabelSettings() {
        label.textColor = labelColor
        label.numberOfLines = labelNumberOfLines
        label.font = .systemFont(ofSize: labelFontSize)
    }

}

