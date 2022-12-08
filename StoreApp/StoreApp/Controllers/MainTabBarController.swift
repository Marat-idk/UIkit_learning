//
//  MainTabBarController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
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
                viewController: BuyViewController(),
                title: "Купить",
                image: UIImage(systemName: "laptopcomputer.and.iphone")
            ),
            generateVC(
                viewController: ForYouViewController(),
                title: "Для вас",
                image: UIImage(systemName: "person.circle")
            ),
            generateVC(
                viewController: SearchViewController(),
                title: "Поиск",
                image: UIImage(systemName: "magnifyingglass")
            ),
            generateVC(
                viewController: CartViewController(),
                title: "Корзина",
                image: UIImage(systemName: "bag")
            )
        ]
    }
    
    func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return navVC
    }
    
    func setTabBarAppearance() {
        tabBar.itemWidth = tabBar.bounds.width / 4
        
        tabBar.itemPositioning = .centered
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1.0)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
