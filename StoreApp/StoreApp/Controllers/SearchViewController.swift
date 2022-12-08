//
//  SearchViewController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        configureNavigationController()
    }

    func configureNavigationController() {
        navigationItem.title = tabBarItem.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
