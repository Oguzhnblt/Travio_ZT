//
//  LabelUtility.swift
//  Travio
//
//  Created by Oğuz on 21.11.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func createLabel(text: String, textSize: AppTheme.FontSize, fontType: AppTheme.FontType, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = AppTheme.getColor(name: .general)
        label.font = UIFont(name: fontType.rawValue, size: textSize.rawValue)
        label.textAlignment = alignment
        return label
    }
}
