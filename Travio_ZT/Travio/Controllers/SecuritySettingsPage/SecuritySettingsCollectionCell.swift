//
//  SecuritySettingsCollectionCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import UIKit
import SnapKit

class SecuritySettingsCollectionCell: UICollectionViewCell {
    
    static let identifier = "securityCell"
    
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.clipsToBounds = true
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 16
        backView.frame.size = CGSize(width: frame.width, height: frame.height)
        return backView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Change Password"
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        
        self.addSubviews(backView)
        backView.addSubview(textField)
        
        backView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        textField.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


