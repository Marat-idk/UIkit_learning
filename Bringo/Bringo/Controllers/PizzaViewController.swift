//
//  PizzaViewController.swift
//  Bringo
//
//  Created by Marat on 20.10.2022.
//

import UIKit

class PizzaViewController: UIViewController {
    
    let pizzas = [
                    Pizza(name: "Маргарита", image: UIImage(named: "pizza_margarita")!),
                    Pizza(name: "Грибная", image: UIImage(named: "pizza_mushrooms")!)
                 ]
    let cellID = "PizzaCellId"
    
    let pizzaTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.allowsSelection = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Pizza"
        
        pizzaTableView.register(PizzaCell.self, forCellReuseIdentifier: cellID)
        
        pizzaTableView.dataSource = self
        pizzaTableView.rowHeight = 150

        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(pizzaTableView)
        
        NSLayoutConstraint.activate(
            [
                pizzaTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                pizzaTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                pizzaTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                pizzaTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ]
        )
    }
    
    func toPizzaDetailVC(name: String, image: UIImage) {
        let navVC = UINavigationController(rootViewController: PizzaDetailViewController(pizzaName: name, pizzaImage: image))
        present(navVC, animated: true, completion: nil)
    }
}

extension PizzaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PizzaCell
        cell.set(pizza: pizzas[indexPath.row])
        // добавляем акшен для каждой ячейки
        cell.addButtonPressed = { (name: String, image: UIImage) -> () in
            self.toPizzaDetailVC(name: name, image: image)
        }
        return cell
    }
}
