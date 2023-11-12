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
    
    func setupView(title: String?, buttonImage: UIImage?, buttonPosition: ButtonPosition?, headerLabelPosition: HeaderLabelPosition ,buttonAction: Selector?, itemsView: [UIView], buttonTintColor: UIColor? = nil) {
        
        lazy var headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = title
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        lazy var containerView = UIView()
        containerView.backgroundColor = UIColor.background
        containerView.clipsToBounds = true
        
        lazy var itemView = UIView()
        itemView.backgroundColor = UIColor.content
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = 80
        itemView.layer.maskedCorners = .layerMinXMinYCorner
        
        lazy var button = UIButton(type: .custom)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = buttonTintColor
        if let action = buttonAction {
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        
        view.addSubviews(containerView, headerLabel, button)
        containerView.addSubview(itemView)
        
        itemView.addSubviews(itemsView)
        
        containerView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        itemView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.left.right.bottom.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }
        
        switch buttonPosition {
            case .left:
                button.snp.makeConstraints { make in
                    make.centerY.equalTo(headerLabel.snp.centerY)
                    make.leading.equalToSuperview().offset(24)
                }
            case .right:
                button.snp.makeConstraints { make in
                    make.centerY.equalTo(headerLabel.snp.centerY)
                    make.trailing.equalToSuperview().offset(-24)
                }
            case .none:
                button.snp.makeConstraints({make in})
        }
        
        switch headerLabelPosition {
            case .left:
                headerLabel.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-15)
                    make.leading.equalToSuperview().offset(24)
                }
            case .right:
                headerLabel.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-15)
                    make.trailing.equalToSuperview().offset(-24)
                }
            case .center:
                headerLabel.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-15)
                    make.centerX.equalToSuperview()
                }
        }
    }
    
    @objc func buttonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

enum ButtonPosition {
    case left
    case right
}

enum HeaderLabelPosition {
    case left
    case right
    case center
}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}