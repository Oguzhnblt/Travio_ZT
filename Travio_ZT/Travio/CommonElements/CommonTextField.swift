//
//  CommonTextField.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit

class CommonTextField: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.getColor(name: .general)
        label.font = AppTheme.getFont(name: .medium, size: .size14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordVisibilityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        button.tintColor = AppTheme.getColor(name: .general)
        button.addTarget(self, action: #selector(passwordVisibility), for: .touchUpInside)
        return button
    }()
    
    private func visibilityButton() {
        if textField.isSecureTextEntry {
            textField.rightView = passwordVisibilityButton
            textField.rightViewMode = .always
        }
        else {
            textField.rightViewMode = .never
        }
    }
    
    
    @objc private func passwordVisibility(sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    private func setupViews() {
        addSubview(backView)
        backView.addSubview(stackView)
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        dropShadow()
        
        visibilityButton()
    }
    
    
    init(labelText: String, textFieldPlaceholder: String, isSecure: Bool) {
        super.init(frame: .zero)
        label.text = labelText
        textField.placeholder = textFieldPlaceholder
        textField.isSecureTextEntry = isSecure
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
