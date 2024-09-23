//
//  ColorExtension.swift
//  u_no
//
//  Created by 백시훈 on 9/9/24.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    static let colors: [String: String] = [
        "mainGreen": "#6FE666",
        "subGreen": "#9CF47B",
        "mainRed" : "#F73F3F",
        "mainBlue" : "#4BA6FB",
        "mainBackground" : "#F5F7F8",
        "subBackground" : "#FBF6EE",
        "subBackground2" : "#F2F2F7"
    ]

    static func color(named name: String) -> UIColor? {
        guard let hexCode = colors[name] else { return nil }
        return UIColor(hexCode: hexCode)
    }

    static var mainGreen: UIColor { return color(named: "mainGreen")! }
    static var subGreen: UIColor { return color(named: "subGreen")! }
    static var mainRed: UIColor { return color(named: "mainRed")! }
    static var mainBlue: UIColor { return color(named: "mainBlue")! }
    static var mainBackground: UIColor { return color(named: "mainBackground")! }
    static var subBackground: UIColor { return color(named: "subBackground")! }
    static var subBackground2: UIColor { return color(named: "subBackground2")! }
}
