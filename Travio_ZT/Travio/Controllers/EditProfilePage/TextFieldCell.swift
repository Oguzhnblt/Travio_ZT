//
//  TextFieldCell.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.
//

import Foundation
import UIKit
import SnapKit

class TextFieldCell: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var fieldLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppTheme.getColor(name: .general)
        label.font = AppTheme.getFont(name: .medium, size: .size14)
        label.textAlignment = .left
        return label
    }()
    
     lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8.0
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fieldLabel, textField])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    private func setupViews() {
        self.addSubview(backView)
        
        backView.dropShadow()
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        backView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func configure(title: String, placeHolder: String) {
        fieldLabel.text = title
        textField.placeholder = placeHolder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
