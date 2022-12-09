//
//  SearchViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var products: [Product]?
    
    // nil - значит результаты поиска будут в текущем VC
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let recentlyWatchedLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Недавно просмотренные"
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let recentlyClearButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Очистить", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitleColor(.gray, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        return btn
    }()
    
    private let recentlyWatchedCollView = RecentlyCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        setupNavigationController()
        setupSearchController()
        
        view.addSubviews(recentlyWatchedLabel, recentlyClearButton,
                         recentlyWatchedCollView)
        setupConstraints()
        
        products = Product.fetchData()
        recentlyWatchedCollView.set(cells: products)
    }

    private func setupNavigationController() {
        navigationItem.title = tabBarItem.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchController() {
        // чтобы можно было взаимодействовать с отображаемым контентом
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по продуктам и магазинам"
        navigationItem.searchController = searchController
        // строка поиска уходит при переходе в другой VC
        definesPresentationContext = true
    }
    
    private func setupConstraints() {
        setupRWLabelConstraints()
        setupRecentlyClearButtonConstraints()
        setupRecentlyWatchedCollConstraints()
    }
    
    private func setupRWLabelConstraints() {
        recentlyWatchedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        recentlyWatchedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        recentlyWatchedLabel.trailingAnchor.constraint(lessThanOrEqualTo: recentlyClearButton.leadingAnchor).isActive = true
    }
    
    private func setupRecentlyClearButtonConstraints() {
        recentlyClearButton.centerYAnchor.constraint(equalTo: recentlyWatchedLabel.centerYAnchor).isActive = true
        recentlyClearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        recentlyClearButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupRecentlyWatchedCollConstraints() {
        recentlyWatchedCollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        recentlyWatchedCollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recentlyWatchedCollView.topAnchor.constraint(equalTo: recentlyWatchedLabel.bottomAnchor, constant: 20).isActive = true
        recentlyWatchedCollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22).isActive = true
    }
    
    
}
