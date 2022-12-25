//
//  MainTabBarController.swift
//  StoreApp
//
//  Created by Marat on 08.12.2022.
//

import UIKit

enum TabBarMode {
    case light
    case dark
}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
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
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return navVC
    }
    
    private func setTabBarAppearance() {
        tabBar.itemWidth = tabBar.bounds.width / 4
        
        tabBar.itemPositioning = .centered
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 18 / 255, green: 18 / 255, blue: 18 / 255, alpha: 1.0)
        appearance.shadowColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func changeTabBarAppearance(to mode: TabBarMode) {
        switch mode {
        case .light:
            tabBar.standardAppearance.backgroundColor = .lightTabBarColor
            tabBar.standardAppearance.shadowColor = .gray
            tabBar.scrollEdgeAppearance?.backgroundColor = .lightTabBarColor
            tabBar.scrollEdgeAppearance?.shadowColor = .gray
        case .dark:
            tabBar.standardAppearance.backgroundColor = .darkTabBarColor
            tabBar.standardAppearance.shadowColor = .clear
            tabBar.scrollEdgeAppearance?.backgroundColor = .darkTabBarColor
            tabBar.scrollEdgeAppearance?.shadowColor = .clear
        }
    }
}
