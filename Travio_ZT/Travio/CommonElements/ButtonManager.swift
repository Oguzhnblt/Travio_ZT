//
//  Buttons.swift
//  Travio
//
//  Created by Oğuz on 21.11.2023.
//

import UIKit

extension UIViewController {
    func createButton(title: String, action: Selector, titleColor: UIColor? = UIColor.white, backgroundColor: UIColor? = AppTheme.getColor(name: .background), isEnabled: Bool = true, font: AppTheme.FontType? = AppTheme.FontType.semibold, size: AppTheme.FontSize? = AppTheme.FontSize.size16) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = AppTheme.getFont(name: font!, size: size!)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.backgroundColor = backgroundColor?.cgColor
        button.isEnabled = isEnabled
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
}

