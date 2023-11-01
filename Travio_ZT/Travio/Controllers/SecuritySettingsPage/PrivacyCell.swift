//
//  PrivacyCell.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import UIKit
import SnapKit

class PrivacyCell: UICollectionViewCell {
    
    static let identifier = "pravicyCell"
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(backView)
        backView.addSubview(label)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        label.snp.makeConstraints({make in
            make.edges.equalToSuperview().inset(8)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
