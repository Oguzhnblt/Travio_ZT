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
    
    
    lazy var textField: CustomLabelTextField = {
        let textField = CustomLabelTextField()
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
