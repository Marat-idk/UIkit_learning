//
//  Device.swift
//  ShopApp
//
//  Created by Marar on 06.10.2022.
//

import Foundation


enum DeviceColor {
    case pink
    case blue
    case midnight
    case starlight
    
    var description: String {
        switch self {
        case .pink:
            return "Pink"
        case .blue:
            return "Blue"
        case .midnight:
            return "Midnight"
        case .starlight:
            return "Starlight"
        }
    }
}

class Device {
    var name: String
    var colors: [DeviceColor]
    var storagePrices: [Int: Int]

    init(name: String, colors: [DeviceColor], storagePrices: [Int: Int]) {
        self.name = name
        self.colors = colors
        self.storagePrices = storagePrices
    }
}
