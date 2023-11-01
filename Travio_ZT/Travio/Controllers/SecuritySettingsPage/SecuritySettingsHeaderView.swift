//
//  SecurityHeaderView.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import UIKit
import SnapKit

class SecuritySettingsHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.textColor = .background
        title.font = UIFont(name: "Poppins-Regular", size: 16)
        title.size(CGSize(width: frame.width, height: frame.height))
        
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().offset(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

