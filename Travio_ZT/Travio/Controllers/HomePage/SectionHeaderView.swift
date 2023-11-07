//
//  SectionHeaderView.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//
import Foundation
import UIKit
import SnapKit


class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        
        title.textColor = .black
        title.font = UIFont(name: "Poppins-Regular", size: 20)
        
        button.setTitleColor(UIColor(named: "backgroundColor"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        
        
        let stackView = UIStackView(arrangedSubviews: [title ,separator, button])
        stackView.axis = .horizontal
        addSubview(stackView)
      
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().offset(25)
        }
        
        button.snp.makeConstraints({make in
            make.left.right.equalToSuperview().offset(290)
            make.top.bottom.equalToSuperview()
        })
        
      
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



