//
//  CafeMenu.swift
//  CafeMario
//
//  Created by Marat on 04.09.2022.
//

import Foundation

class MenuPosition {
    var name: String
    var price: Int
    var ingredients: [String]
    
    init(name: String, price: Int, ingredients: [String]) {
        self.name = name
        self.price = price
        self.ingredients = ingredients
    }
}

let menu = [
    MenuPosition(name: "Салат Цезарь", price: 300, ingredients: ["Помидор", "Салат Айсберг", "Сухарики", "Курица"]),
    MenuPosition(name: "Салат Греческий", price: 40, ingredients: ["Помидор", "Сыр брынза", "Болгарский перец", "Огурцы"])
]

