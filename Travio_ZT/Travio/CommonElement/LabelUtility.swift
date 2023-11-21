//
//  LabelUtility.swift
//  Travio
//
//  Created by Oğuz on 21.11.2023.
//

import Foundation
import UIKit

class LabelUtility {
    static func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.font = UIFont(name: fontName, size: textSize)
        label.textAlignment = alignment
        return label
    }
}
