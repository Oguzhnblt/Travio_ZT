//
//  PrivacyCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class PrivacyCell: UITableViewCell {
    
    static let reuseIdentifier = "PrivacyCell"
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()
    
    lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        return toggle
    }()
    
    private func setupViews() {
        contentView.addSubview(backView)
        
        let stackView = UIStackView(arrangedSubviews: [label, UIView(), toggleSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        backView.addSubview(stackView)
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(4)

        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(74)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    func configure(text: String, isOn: Bool) {
        label.text = text
        toggleSwitch.isOn = isOn
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
