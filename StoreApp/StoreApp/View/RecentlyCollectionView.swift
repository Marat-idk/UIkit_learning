//
//  RecentlyCollectionView.swift
//  StoreApp
//
//  Created by Marat on 09.12.2022.
//

import UIKit

class RecentlyCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private var products: [Product] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        register(RecentlyCollectionViewCell.self, forCellWithReuseIdentifier: RecentlyCollectionViewCell.identifier)
        print(RecentlyCollectionViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        // расстояние между ячейками
        layout.minimumLineSpacing = 10
        // откуда начинаются ячейки по краям
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        // убираем горизонтальный и вертикальные ползунки
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // передача продуктов
    func set(cells: [Product]?) {
        if let cells = cells {
            self.products = cells
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentlyCollectionViewCell.identifier, for: indexPath) as! RecentlyCollectionViewCell
        
        if products.isEmpty { return cell}
        
        let product = products[indexPath.row]
        
        if let mainImage = product.images.first {
            cell.productImageView.image = mainImage
        }
        cell.productNameLabel.text = product.name
        
        return cell
    }

    // UICollectionViewDelegateFlowLayout -   отвечает за размер ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2.76, height: frame.height)
    }
}
