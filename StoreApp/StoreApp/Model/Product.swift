//
//  Product.swift
//  StoreApp
//
//  Created by Marat on 09.12.2022.
//

import Foundation
import UIKit

class Product {
    var name: String
    var images: [UIImage?]
    var price: Double
    var colors: [UIColor]
    var isFavorite = false
    
    init(name: String, images: [UIImage?], price: Double, colors: [UIColor]) {
        self.name = name
        self.images = images
        self.price = price
        self.colors = colors
    }
    
    static func fetchData() -> [Product]? {
        let products = [
            Product(
                name: "Рюкзак XD Design Bobby Hero Small для ноутбука до 13,3\", черный",
                images: [
                    UIImage(named: "backpack_1"),
                    UIImage(named: "backpack_2"),
                    UIImage(named: "backpack_3")
                ],
                price: 8792.00,
                colors: [
                    .gray,
                    .black
                ]
            ),
            Product(
                name: "Спортивный ремешок для Apple Watch 44 мм, Black Unity",
                images: [
                    UIImage(named: "sportStrap_1"),
                    UIImage(named: "sportStrap_2"),
                    UIImage(named: "sportStrap_3")
                ],
                price: 3990.00,
                colors: [
                    .red,
                    .black
                ]
            ),
            Product(
                name: "Чехол-коверт Native Union Stow Lite Sleeve 16\", крафтовый",
                images: [
                    UIImage(named: "case_1"),
                    UIImage(named: "case_2"),
                    UIImage(named: "case_3")
                ],
                price: 7590.00,
                colors: [
                    .brown,
                    .lightGray
                ]
            )
        ]
        return products
    }
    
    func getPrice() -> String {
        return "\(price) руб."
    }
}
