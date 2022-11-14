//
//  MainTabBarController.swift
//  LabelApp
//
//  Created by Maxim Raskevich on 13.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBar()
        setTabBarAppearance()
    }
    
    func generateTabBar() {
        self.viewControllers = [
            generateVC(
                viewController: HomeViewController(),
                title: "Home",
                image: UIImage(systemName: "house.fill")
            ),
            generateVC(
                viewController: SettingsViewController(),
                title: "Settings",
                image: UIImage(systemName: "gearshape.fill"))
        ]
    }
    
    func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return navVC
    }
    
    func setTabBarAppearance() {
        // для невыбранного айтема
        tabBar.unselectedItemTintColor = .gray
        // для выбранного айтема
        tabBar.tintColor = .orange
    }
}
