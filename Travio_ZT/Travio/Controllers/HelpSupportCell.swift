//
//  HelpSupportCell.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.
//

import Foundation
import UIKit
import SnapKit

struct HelpSupportData {
    let iconName: String
    let labelText: String
}

class HelpSupportCell: UICollectionViewCell {
    
    static let identifier = "settings"
    
    var buttonAction: (() -> Void)?
    
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
    
    func configure(with data: HelpSupportData) {
        iconImageView.image = UIImage(named: data.iconName)
        label.text = data.labelText
    }
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.clipsToBounds = true
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 16
        backView.frame.size = CGSize(width: frame.width, height: frame.height)
        return backView
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageIconView = UIImageView()
        imageIconView.contentMode = .scaleAspectFit
        imageIconView.image = UIImage(systemName: "person.circle.fill")
        return imageIconView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "img_right_arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, label, UIView(), button])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        backView.addSubview(horizontalStackView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        horizontalStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
