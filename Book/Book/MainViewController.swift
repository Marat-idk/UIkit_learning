//
//  ViewController.swift
//  Book
//
//  Created by Marat on 22.11.2022.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func updateFontSize(fontSize: CGFloat)
    func updateFontWeight(fontWeight: UIFont.Weight)
    func updateBackgroundColor(background: UIColor, textColor: UIColor)
}

class MainViewController: UIViewController {
    
    lazy var bookTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = theMetamorphosisText
        tv.textColor = .label
        tv.font = .systemFont(ofSize: 20)
        tv.isEditable = false
        // чтобы текст в скролл вью не был под navigation bar
        tv.contentInsetAdjustmentBehavior = .never
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationController()
        
        view.addSubview(bookTextView)

        NSLayoutConstraint.activate(
            [
                bookTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                bookTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                bookTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bookTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
    
    func setupNavigationController() {
        navigationItem.title = "Book"
        
        // вид навбара
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray5
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // navigationBar buttons
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "textformat.size"), style: .plain, target: self, action: #selector(showPopoverSettingsVC(barButton:)))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)
        let bookmarkButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [bookmarkButton, searchButton, settingsButton]
    }
    
    @objc func showPopoverSettingsVC(barButton: UIBarButtonItem) {
        let settingsVC = SettingsViewController(
                                        fontSize: bookTextView.font?.pointSize ?? 14,
                                        fontWeight: bookTextView.font?.weight ?? .regular
                                        )
        settingsVC.delegate = self
        settingsVC.modalPresentationStyle = .popover
        
        let popoverVC = settingsVC.popoverPresentationController
        popoverVC?.delegate = self
        
        // поповер будет появляться отсюда
        popoverVC?.barButtonItem = barButton
        // размер вью поповера
        settingsVC.preferredContentSize = CGSize(width: 300, height: 300)
        
        self.present(settingsVC, animated: true, completion: nil)
    }
    
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    // если не возвращать .none, то вью на айфонах будет открываться на весь экран (не то, что нужно)
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension MainViewController: MainViewControllerDelegate {
    func updateFontSize(fontSize: CGFloat) {
        bookTextView.font = bookTextView.font?.withSize(fontSize)
    }
    
    func updateFontWeight(fontWeight: UIFont.Weight) {
        bookTextView.font = .systemFont(
            ofSize: bookTextView.font?.pointSize ?? 14,
            weight: fontWeight)
    }
    
    func updateBackgroundColor(background: UIColor, textColor: UIColor) {
        bookTextView.backgroundColor = background
        view.backgroundColor = background
        bookTextView.textColor = textColor
        navigationController?.navigationBar.tintColor = textColor == .lightGray ? .darkGray : textColor
    }
}
