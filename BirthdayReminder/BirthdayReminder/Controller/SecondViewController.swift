//
//  SecondViewController.swift
//  BirthdayReminder
//
//  Created by Marat on 13.09.2022.
//

import UIKit

protocol SecondVCDelegate: AnyObject {
    func update(person: Person)
}

class SecondViewController: UIViewController {
    var person = Person()
    
    // изображение аватарки
    let avatar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "avatar")
        img.backgroundColor = .systemGray5
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 18)

        return lbl
    }()
    
    let daysBeforeBirthdayLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationController()
    }
    
    func setupNavigationController() {
        title = "Birthday"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray5
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toThirdViewController(_:)))
        
    }
    
    @objc func toThirdViewController(_ sender: Any) {
        performSegue(withIdentifier: "toThirdVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC" {
            if let destVC = segue.destination as? UINavigationController,
                let dvc = destVC.topViewController as? ThirdViewController {
                dvc.secondVCDelegate = self
            }
        }
    }
    
    // округление изображения
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatar.setRounded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.scrollEdgeAppearance = .none
    }
    
    func setupAvatar() {
        avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        avatar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor).isActive = true
    }
    
    func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: avatar.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupDaysBeforeBirthday() {
        daysBeforeBirthdayLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        daysBeforeBirthdayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        daysBeforeBirthdayLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        daysBeforeBirthdayLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func daysBeforeBirthday(birthday: Date) -> Int {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let date = cal.startOfDay(for: birthday)
        let components = cal.dateComponents([.day, .month], from: date)
        let nextDate = cal.nextDate(after: today, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
        return cal.dateComponents([.day], from: today, to: nextDate ?? today).day ?? 0
    }
}

extension SecondViewController: SecondVCDelegate {
    func update(person: Person) {
        person.copy(from: person)
        
        nameLabel.text = person.name
        if !Calendar.current.isDate(person.birthday, equalTo: Date(), toGranularity: .day) {
            daysBeforeBirthdayLabel.text = "\(daysBeforeBirthday(birthday: person.birthday)) дн."
        }
        
        view.addSubview(avatar)
        view.addSubview(nameLabel)
        view.addSubview(daysBeforeBirthdayLabel)
        setupAvatar()
        setupNameLabel()
        setupDaysBeforeBirthday()
    }
}


