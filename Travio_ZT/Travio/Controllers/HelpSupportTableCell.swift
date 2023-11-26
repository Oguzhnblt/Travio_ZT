//
//  HelpSupportTableCell.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//


import Foundation
import UIKit
import SnapKit

class HelpSupportTableCell: UITableViewCell {
    static let cellReuseIdentifier = "cell"

   private lazy var backView: UIView = {
        let view = UIView()
       view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppTheme.getColor(name: .general)
        label.font = AppTheme.getFont(name: .medium, size: .size14)
        label.numberOfLines = 0
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.getFont(name: .light, size: .size10)
        label.numberOfLines = 0
        label.textColor = AppTheme.getColor(name: .general)
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_arrow" )
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupUI()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setupUI()
       }
    
    func setupUI() {
        addSubview(backView)
        
        backView.addSubviews(titleLabel, subtitleLabel, iconImageView)
        
        backView.dropShadow()
        backView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).inset(20)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.width.height.equalTo(15)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
    }
}

