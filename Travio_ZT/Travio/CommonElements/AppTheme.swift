//
//  AppTheme.swift
//  Travio
//
//  Created by Oğuz on 24.11.2023.
//

import UIKit

class AppTheme {
    
    enum ColorType: String {
        case background = "backgroundColor"
        case content = "contentColor"
        case general = "generalColor"
        case seeButton = "seeAllColor"
    }
    
    enum FontType: String {
        case light = "Poppins-Light" // weight = 300
        case regular = "Poppins-Regular" // weight = 400
        case medium = "Poppins-Medium" // weight = 500
        case semibold = "Poppins-SemiBold" // weight = 600
    }
    
    enum FontSize: CGFloat {
        case size10 = 10
        case size12 = 12
        case size14 = 14
        case size16 = 16
        case size20 = 20
        case size24 = 24
        case size30 = 30
        case size34 = 34
    }
    
    
    static func getFont(name: FontType, size: FontSize) -> UIFont {
        if let font = UIFont(name: name.rawValue, size: size.rawValue) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
    }
    
    static func getColor(name: ColorType) -> UIColor {
        if let color = UIColor(named: name.rawValue) {
            return color
        } else {
            return UIColor.systemBackground
        }
    }
    
}
