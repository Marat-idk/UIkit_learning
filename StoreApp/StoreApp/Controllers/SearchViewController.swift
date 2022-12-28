//
//  SearchViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

protocol ProductDelegate: AnyObject {
    func toProductVC(product: Product)
}

class SearchViewController: UIViewController {
    
    private var products: [Product]?
    
    // nil - значит результаты поиска будут в текущем VC
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    private let contentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
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
    
    private let recentlyRequestsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Варианты запросов"
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let recentlyWatchedCollView = RecentlyCollectionView()
    private var recentlyRequestsStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        setupNavigationController()
        setupSearchController()
        setupStackView()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(recentlyWatchedLabel, recentlyClearButton,
                         recentlyWatchedCollView, recentlyRequestsLabel, recentlyRequestsStackView)
        setupConstraints()
        
        products = Product.fetchData()
        recentlyWatchedCollView.set(cells: products)
        recentlyWatchedCollView.productDelegate = self
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
    
    private func setupStackView() {
        recentlyRequestsStackView = UIStackView()
        recentlyRequestsStackView.translatesAutoresizingMaskIntoConstraints = false
        recentlyRequestsStackView.axis = .vertical
        recentlyRequestsStackView.alignment = .leading
        recentlyRequestsStackView.distribution = .fillEqually
        recentlyRequestsStackView.spacing = 15
        
        let searches = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
        for i in 0...3 {
            let button = UIButton()
            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            button.tintColor = .lightGray
            button.setTitle(" \(searches[i])", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.lightGray, for: .highlighted)
            button.titleLabel?.font = .systemFont(ofSize: 22)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            
            recentlyRequestsStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupRWLabelConstraints()
        setupRecentlyClearButtonConstraints()
        setupRecentlyWatchedCollConstraints()
        setupRecentlyRequestsLabel()
        setupRecentlyRequestStackView()
    }
    
    private func setupScrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupContentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupRWLabelConstraints() {
        recentlyWatchedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        recentlyWatchedLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        recentlyWatchedLabel.trailingAnchor.constraint(lessThanOrEqualTo: recentlyClearButton.leadingAnchor).isActive = true
    }
    
    private func setupRecentlyClearButtonConstraints() {
        recentlyClearButton.centerYAnchor.constraint(equalTo: recentlyWatchedLabel.centerYAnchor).isActive = true
        recentlyClearButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        recentlyClearButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupRecentlyWatchedCollConstraints() {
        recentlyWatchedCollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recentlyWatchedCollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recentlyWatchedCollView.topAnchor.constraint(equalTo: recentlyWatchedLabel.bottomAnchor, constant: 20).isActive = true
        recentlyWatchedCollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22).isActive = true
    }
    
    private func setupRecentlyRequestsLabel() {
        recentlyRequestsLabel.topAnchor.constraint(equalTo: recentlyWatchedCollView.bottomAnchor, constant: 20).isActive = true
        recentlyRequestsLabel.leadingAnchor.constraint(equalTo: recentlyWatchedLabel.leadingAnchor).isActive = true
        recentlyRequestsLabel.trailingAnchor.constraint(equalTo: recentlyClearButton.trailingAnchor).isActive = true
    }
    
    private func setupRecentlyRequestStackView() {
        recentlyRequestsStackView.topAnchor.constraint(equalTo: recentlyRequestsLabel.bottomAnchor, constant: 20).isActive = true
        recentlyRequestsStackView.leadingAnchor.constraint(equalTo: recentlyRequestsLabel.leadingAnchor).isActive = true
        recentlyRequestsStackView.trailingAnchor.constraint(equalTo: recentlyRequestsLabel.trailingAnchor).isActive = true
//        recentlyRequestsStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension SearchViewController: ProductDelegate {
    func toProductVC(product: Product) {
        let productVC = ProductViewController(product: product)
        navigationController?.pushViewController(productVC, animated: true)
    }
}
