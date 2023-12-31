//
//  PrivacyCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class PrivacyField: UIView {
    
    var switchChanged: ((Bool) -> Void)?

    
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
        label.textColor = AppTheme.getColor(name: .general)
        label.font = AppTheme.getFont(name: .medium, size: .size14)
        return label
    }()
    
    lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return toggle
    }()
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        switchChanged?(sender.isOn)
        }
    
    private func setupViews() {
        self.addSubview(backView)
        
        let stackView = UIStackView(arrangedSubviews: [label, UIView(), toggleSwitch])
        stackView.axis = .horizontal
        stackView.spacing = 4
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
        
        dropShadow()
    }
    
    init(labelText: String, isOn: Bool) {
        super.init(frame: .zero)
        label.text = labelText
        toggleSwitch.isOn = isOn
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
