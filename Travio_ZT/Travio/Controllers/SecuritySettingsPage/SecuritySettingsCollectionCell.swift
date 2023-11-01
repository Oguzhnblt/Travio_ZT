//
//  SecuritySettingsCollectionCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import UIKit

class SecuritySettingsCollectionCell: UICollectionViewCell {
    
    static let identifier = "securityCell"
    
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .content
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        
        self.addSubviews(backView)
        backView.addSubview(textField)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
