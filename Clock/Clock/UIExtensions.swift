//
//  UIExtensions.swift
//  Clock
//
//  Created by Marat on 05.11.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addCircle(width: CGFloat, height: CGFloat) {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: width / 2,
                y: height / 2
                ),
            radius: 39.0,
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.lineWidth = 1.7
        
        self.layer.addSublayer(circleLayer)
    }
}
