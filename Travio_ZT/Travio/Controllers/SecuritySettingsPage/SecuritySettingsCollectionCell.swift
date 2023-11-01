//
//  SecuritySettingsCollectionCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class SecuritySettingsCollectionCell: UICollectionViewCell {
    
    static let identifier = "securityCell"
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .content
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.textAlignment = .left
        label.text = "New Password"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8.0
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    func setupCell(with labelText: String) {
        label.text = labelText
    }
    
    private func setupViews() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        backView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}




