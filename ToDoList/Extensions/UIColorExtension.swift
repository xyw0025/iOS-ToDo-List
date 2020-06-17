//
//  UIColorExtension.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/17.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var theme: UIColor { return UIColor(hex: "#FF8552") }
    struct LightModeColor {
        static var cellColor: UIColor  { return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2057737586) }
        static var cellTriggerdColor: UIColor { return #colorLiteral(red: 1, green: 0.5215686275, blue: 0.3215686275, alpha: 0.4017283818) }
        static var textColor: UIColor {return .black}
    }
}


// hex code to UIColor
extension UIColor{
    public  convenience init(hex : String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
