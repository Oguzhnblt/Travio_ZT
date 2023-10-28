//
//  CategoryHeaderView.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation
import UIKit
import SnapKit

class CategoryHeaderView: UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.textColor = .black
        return label
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().offset(55)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
