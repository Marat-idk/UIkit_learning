//
//  MainTabBarController.swift
//  Clock
//
//  Created by Maxim Raskevich on 31.10.2022.
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
                viewController: WorldClockViewController(),
                title: "Мировые часы",
                image: UIImage(systemName: "globe")
            ),
            generateVC(
                viewController: AlarmViewController(),
                title: "Будильник",
                image: UIImage(systemName: "alarm.fill")
            ),
            generateVC(
                viewController: StopwatchViewController(),
                title: "Секундомер",
                image: UIImage(systemName: "stopwatch.fill")
            ),
            generateVC(
                viewController: TimerViewController(),
                title: "Таймер",
                image: UIImage(systemName: "timer")
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
        // для невыбранного айтема
        tabBar.unselectedItemTintColor = .gray
        // для выбранного айтема
        tabBar.tintColor = .orange
    
        //tabBar.barTintColor =
    }

}
