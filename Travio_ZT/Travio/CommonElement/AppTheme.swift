//
//  AppTheme.swift
//  Travio
//
//  Created by Oğuz on 24.11.2023.
//

import UIKit

class AppTheme {
    enum FontSize: CGFloat {
        case size10 = 10
        case size12 = 12
        case size14 = 14
        case size16 = 16
        case size18 = 18
        case size20 = 20
        case size22 = 22
        case size24 = 24
        case size26 = 26
        case size28 = 28
        case size30 = 30
        case size32 = 32
        case size34 = 34
    }
    
    enum FontType: String {
        case thin = "Poppins-Thin" // weight = 100
        case light = "Poppins-Light" // weight = 300
        case regular = "Poppins-Regular" // weight = 400
        case medium = "Poppins-Medium" // weight = 500
        case semibold = "Poppins-SemiBold" // weight = 600
    }
    
    static func getFont(name: FontType, size: FontSize) -> UIFont {
        if let font = UIFont(name: name.rawValue, size: size.rawValue) {
            return font
        } else {
            print("Error: Unable to create font \(name.rawValue) with size \(size.rawValue)")
            return UIFont.systemFont(ofSize: size.rawValue)
        }
    }

}
