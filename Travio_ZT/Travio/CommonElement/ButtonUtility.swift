//
//  Buttons.swift
//  Travio
//
//  Created by Oğuz on 21.11.2023.
//

import UIKit

class ButtonUtility {
    static func createButton(from viewController: UIViewController, title: String, action: Selector, titleColor: UIColor? = UIColor.white, backgroundColor: UIColor? = UIColor(named: "backgroundColor"), isEnabled: Bool = true) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.backgroundColor = backgroundColor?.cgColor
        button.isEnabled = isEnabled 
        button.addTarget(viewController.self, action: action, for: .touchUpInside)
        
        return button
    }

    @objc static func buttonTapped() {
    }
}

