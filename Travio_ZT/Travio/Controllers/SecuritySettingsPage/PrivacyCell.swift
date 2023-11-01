//
//  PrivacyCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class PrivacyCell: UICollectionViewCell {
    
    static let identifier = "privacyCell"
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()
    
    let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        return toggle
    }()
    
    private func setupViews() {
        contentView.addSubview(backView)
        
        let stackView = UIStackView(arrangedSubviews: [label, UIView(), toggleSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 8 
        backView.addSubview(stackView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.width.equalTo(50)
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
