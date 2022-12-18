//
//  ProductViewController.swift
//  StoreApp
//
//  Created by Marat on 17.12.2022.
//

import UIKit

class ProductViewController: UIViewController {
    

    private var product: Product
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = product.name
        lbl.font = .boldSystemFont(ofSize: 19)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = product.getPrice()
        lbl.font = .systemFont(ofSize: 18)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var productScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        // включить перелистывание
        sv.isPagingEnabled = true
        sv.contentSize = CGSize(width: Int(view.bounds.size.width) * product.images.count, height: 0)
        return sv
    }()
    
    lazy var subnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = product.name
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let toCartButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Добавить в корзину", for: .normal)
        btn.setTitleColor(.lightGray, for: .highlighted)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private var buttonsStackView: UIStackView!
    private var compatibilityStackView: UIStackView!
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        
        setupNavigationController()
        setupScrollView()
        setupButtonStackView()
        setupCompatibilityStackView()
        
        view.addSubviews(nameLabel, priceLabel,
                         productScrollView, subnameLabel,
                         buttonsStackView, compatibilityStackView, toCartButton)
        
        setupConstraints()
    }
    
    private func setupNavigationController() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
        
        let favoriteImage = product.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favoriteButtonTapped(_:)))
        
        navigationItem.rightBarButtonItems = [shareButton, favoriteButton]
    }
    
    @objc func favoriteButtonTapped(_ button: UIBarButtonItem) {
        product.isFavorite = !product.isFavorite
        button.image = product.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    private func setupScrollView() {
        let width = view.bounds.size.width
        let height = view.bounds.size.height / 5
        var imageViewRect = CGRect(origin: view.bounds.origin, size: .init(width: width, height: height))
        for image in product.images {
            if let image = image {
                let imageView = getImageView(image: image, rect: imageViewRect)
                productScrollView.addSubview(imageView)
                imageViewRect.origin.x += view.bounds.size.width
            }
        }
        productScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    private func getImageView(image: UIImage, rect: CGRect) -> UIImageView {
        let imageView = UIImageView(frame: rect)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func setupButtonStackView() {
        buttonsStackView = UIStackView()
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 15

        for color in product.colors {
            let button = CustomButton()
            button.backgroundColor = color
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.cgColor
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    private func setupCompatibilityStackView() {
        compatibilityStackView = UIStackView()
        compatibilityStackView.translatesAutoresizingMaskIntoConstraints = false
        compatibilityStackView.axis = .horizontal
        compatibilityStackView.alignment = .center
        compatibilityStackView.distribution = .equalCentering
        compatibilityStackView.spacing = 10

        let compatibilityText = "Совместимо с MacBook Pro - Евгений"
        // для того, чтобы текст лейбла был разного цвета (знаю, что это должны быть по идее лейб и кнопка)
        let myMutableString = NSMutableAttributedString(
            string: compatibilityText,
            attributes:
                [
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
                    NSAttributedString.Key.foregroundColor: UIColor.lightGray
                ]
        )
        // индекс с которого начинается другой цвет
        let startInx = compatibilityText.distance(from: compatibilityText.startIndex, to: compatibilityText.firstIndex(of: "M") ?? compatibilityText.startIndex)
        // длина строки которая будет в другом цвете
        let length = compatibilityText.distance(from: compatibilityText.firstIndex(of: "M") ?? compatibilityText.startIndex, to: compatibilityText.endIndex)
        // приминение атрибутов
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: startInx, length: length))
        
        let checkTextLabel = UILabel()
        checkTextLabel.attributedText = myMutableString
        
        let checkImage = UIImage(systemName: "checkmark.circle.fill")
        let checkImageView = UIImageView()
        checkImageView.image = checkImage
        checkImageView.contentMode = .scaleAspectFit
        checkImageView.tintColor = .green
        
        compatibilityStackView.addArrangedSubviews(checkImageView, checkTextLabel)
    }
    
    private func setupConstraints() {
        setupNameLabelConstraints()
        setupPriceLabelConstraints()
        setupScrollViewConstrains()
        setupSubnameLabelConstrains()
        setupButtonsStackViewConstrains()
        setupCompatibilityStackViewConstrains()
        setupToCartButtonConstraints()
    }

    private func setupNameLabelConstraints(){
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupPriceLabelConstraints() {
        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupScrollViewConstrains() {
        productScrollView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        productScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        productScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        productScrollView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 1/4.5).isActive = true
    }
    
    private func setupSubnameLabelConstrains() {
        subnameLabel.topAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 10).isActive = true
        subnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        subnameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupButtonsStackViewConstrains() {
        buttonsStackView.topAnchor.constraint(equalTo: subnameLabel.bottomAnchor, constant: 20).isActive = true
        buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonsStackView.widthAnchor.constraint(equalToConstant: 95).isActive = true
    }
    
    private func setupCompatibilityStackViewConstrains() {
        compatibilityStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 30).isActive = true
        compatibilityStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupToCartButtonConstraints() {
        toCartButton.topAnchor.constraint(equalTo: compatibilityStackView.bottomAnchor, constant: 30).isActive = true
        toCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        toCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        toCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        toCartButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}


class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
}
