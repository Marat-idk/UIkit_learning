//
//  RecentlyCollectionViewCell.swift
//  StoreApp
//
//  Created by Marat on 09.12.2022.
//

import UIKit

class RecentlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: RecentlyCollectionViewCell.self)
    
    let productImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.numberOfLines = 3
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemFill
        contentView.addSubviews(productImageView, productNameLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        setupProductImageViewConstraints()
        setupProductNameLabelConstraints()
    }
    
    private func setupProductImageViewConstraints() {
        productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupProductNameLabelConstraints() {
        productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10).isActive = true
        productNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
    }
    
}
