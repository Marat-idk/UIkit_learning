//
//  StartPageViewController.swift
//  StoreApp
//
//  Created by Marat on 30.12.2022.
//

import UIKit

class StartPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let initialPage = 0
    var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        setupPageVC()
        setPageControllAppearance()
        self.dataSource = self
        
        setButtonForLastPage()
    }
    
    // Создание контроллеров и установка стартового контроллера
    private func setupPageVC() {
        controllers = [
                generateVC(name: "Добро пожаловать!", color: .white),
                generateVC(name: "Я тут учу UIKit", color: .white),
                generateVC(name: "Надеюсь, вам понравится", color: .white)
            ]
        setViewControllers(
            [controllers[initialPage]],
            direction: .forward,
            animated: true,
            completion: nil)
    }
    
    private func generateVC(name: String, color: UIColor) -> UIViewController {
        let pageVC = PageViewCotroller(name: name, color: color)
        return pageVC
    }
    
    private func setPageControllAppearance() {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [StartPageViewController.self])
        appearance.pageIndicatorTintColor = .gray
        appearance.currentPageIndicatorTintColor = .black
        // отключает переключение между страницами при продолжительном зажатии
        appearance.allowsContinuousInteraction = false
    }
    
    // MARK: Дабавление кнопки на последний vc для перехода в основное меню
    private func setButtonForLastPage() {
        guard let lastVC = controllers.last as? PageViewCotroller else { return }
        lastVC.setToMainButton()
    }
    
    // MARK: возвращаем контроллер, который должен быть до текущего
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        if index > 0 {
            return controllers[index - 1]
        }
        return nil
    }
    
    // MARK: возвращаем контроллер, который должен быть после текущего
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        if index < controllers.count - 1 {
            return controllers[index + 1]
        }
        return nil
    }
    
    // колличество точек у PageController'a
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    // установка начальной точки
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

fileprivate class PageViewCotroller: UIViewController {
    
    private var name: String
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = name
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 34)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    init(name: String, color: UIColor) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate(
            [
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
    
    fileprivate func setToMainButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Поехали", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .black
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(toMainBattonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate(
            [
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
            ]
        )
    }
    
    @objc private func toMainBattonTapped(_ button: UIButton) {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
