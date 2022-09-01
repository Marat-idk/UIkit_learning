//
//  Reverser.swift
//  Alert_MVC
//
//  Created by Marat on 01.09.2022.
//

import Foundation

class Reverser {
    var str: String?
    
    init(toReverse str: String) {
        self.str = str
    }
    
    convenience init() {
        self.init(toReverse: "")
    }
    
    func reverse() {
        if let str = str?.reversed() {
            self.str = String(str)
        }
    }
    
}
