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


extension UIColor {
    static var unselectedStartButtonBackground: UIColor {
        return hexStringToUIColor(hex: "092A11")
    }
    // аналогичен .systemGreen
    static var unselectedStartButtonTextColor: UIColor {
        return hexStringToUIColor(hex: "2ECA55")
    }
    
    static var selectedStartButtonBackground: UIColor {
        return hexStringToUIColor(hex: "330E0B")
    }
    
    static var selectedStartButtonTextColor: UIColor {
        return hexStringToUIColor(hex: "D73B30")
    }
    
    static var inActiveLapButtonBackground: UIColor {
        return hexStringToUIColor(hex: "1C1C1E")
    }
    
    static var inActiveLapButtonTextColor: UIColor {
        return .lightGray
    }
    
    static var activeLapButtonBackground: UIColor {
        return hexStringToUIColor(hex: "333333")
    }
    
    static var activeLapButtonTextColor: UIColor {
        return hexStringToUIColor(hex: "F9F9F9")
    }
    
    
    // hex to UIColor
    static func hexStringToUIColor (hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
