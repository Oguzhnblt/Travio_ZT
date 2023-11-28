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
    
    func configure(_ model: HelpSupportModel) {
        
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        subtitleLabel.isHidden = !model.isExpanded
        iconImageView.image = (model.isExpanded ? UIImage(named: "img_arrow") : UIImage(named: "img_right_arrow"))
    }
    
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
        label.isHidden = true
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_arrow" )
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,iconImageView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainStackView, subtitleLabel])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 12
       
        return  stackView
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
        contentView.addSubview(backView)
        backView.dropShadow()
        backView.addSubviews(stackView)
        
        backView.snp.makeConstraints({ make in
            make.edges.equalToSuperview().inset(8)
        })
        
        stackView.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(12)
            make.right.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(15)
        })
        
        iconImageView.snp.makeConstraints({$0.size.equalTo(18)})
    }
}

