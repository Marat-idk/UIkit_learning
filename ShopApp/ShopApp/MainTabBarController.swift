//
//  MainTabBarController.swift
//  ShopApp
//
//  Created by Marat on 01.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()
    }
    
    // добавляем элементы таббар
    private func generateTabBar() {
        self.viewControllers = [
            generateVC(
                viewController: HomeViewController(),
                title: "Главное",
                image: UIImage(systemName: "house.fill")
            ),
            generateVC(
                viewController: CartViewController(),
                title: "Корзина",
                image: UIImage(systemName: "cart.fill")
            ),
            generateVC(
                viewController: ProfileViewController(),
                title: "Профиль",
                image: UIImage(systemName: "person.fill")
            )
        ]
    }
    
    // генерируем элементы таббара с заголовком и картинкой
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return navigationVC
    }
    
    // изменяем внешний вид таббара
    private func setTabBarAppearance() {
        let positionOnX = 10.0
        let positionOnY = 13.0
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: .init(
                        x: positionOnX,
                        y: tabBar.bounds.minY - positionOnY * 0.5,
                        width: width,
                        height: height
            ),
            cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        // задание линии на границах таббара
        roundLayer.lineWidth = 0.8
        roundLayer.strokeColor = UIColor.black.cgColor
        roundLayer.fillColor = UIColor.black.cgColor
        
        tabBar.itemWidth = width / 5
        // tabBar.itemPositioning = .centered
        
        // задание цвета таббара
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        
        tabBar.unselectedItemTintColor = .tabBarItemColor
        tabBar.tintColor = .tabBarItemTintColor
    }

}
