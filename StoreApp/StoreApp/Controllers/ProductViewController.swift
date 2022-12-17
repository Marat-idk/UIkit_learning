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
        
        view.addSubviews(nameLabel, priceLabel, productScrollView)
        
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
        let height = view.bounds.size.height / 4.5
        var imageViewRect = CGRect(origin: view.bounds.origin, size: .init(width: width, height: height))
        for image in product.images {
            if let image = image {
                let imageView = getImageView(image: image, rect: imageViewRect)
                productScrollView.addSubview(imageView)
                imageViewRect.origin.x += view.bounds.size.width
            }
        }
    }
    
    private func getImageView(image: UIImage, rect: CGRect) -> UIImageView {
        let imageView = UIImageView(frame: rect)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func setupConstraints() {
        setupNameLabelConstraints()
        setupPriceLabelConstraints()
        setupScrollViewConstrains()
    }

    private func setupNameLabelConstraints(){
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupPriceLabelConstraints() {
        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupScrollViewConstrains() {
//        productScrollView.backgroundColor = .red
        productScrollView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        productScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        productScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        productScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4.5).isActive = true
    }
    
}
