//
//  ColoredView.swift
//  trafficlight
//
//  Created by Marat on 02.01.2023.
//

import UIKit

class ColoredView: UIView {
    
    init(with color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
