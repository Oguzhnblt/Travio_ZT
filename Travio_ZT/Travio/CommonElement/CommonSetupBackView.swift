//
//  CommonSetupBackView.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    func setupCommonHeaderView(title: String, buttonAction: Selector?) {
        lazy var headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = title
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        lazy var securityItemView = UIView()
        securityItemView.backgroundColor = UIColor(named: "contentColor")
        securityItemView.clipsToBounds = true
        securityItemView.layer.cornerRadius = 80
        securityItemView.layer.maskedCorners = .layerMinXMinYCorner
        
        lazy var backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        if let action = buttonAction {
            backButton.addTarget(self, action: action, for: .touchUpInside)
        }
        
        // Add these views to your main view or any desired container view
        view.addSubview(headerLabel)
        view.addSubview(securityItemView)
        view.addSubview(backButton)
        
        // Use SnapKit for constraints
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        securityItemView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(160) // Customize the size as needed
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    @objc func buttonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
