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
    
    static let reuseIdentifier = "Security"
    
     lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont(name: "Poppins-Regular", size: 20)

       
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                        
        setupViews()
    }
    
    private func setupViews() {
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        title.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
