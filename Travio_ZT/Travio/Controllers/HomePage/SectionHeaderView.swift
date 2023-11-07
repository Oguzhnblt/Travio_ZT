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
                
        title.textColor = .black
        title.font = UIFont(name: "Poppins-Regular", size: 20)
        
        button.setTitleColor(UIColor(named: "backgroundColor"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        
        
        let stackView = UIStackView(arrangedSubviews: [title, button])
        stackView.axis = .horizontal
        stackView.alignment = .center
        addSubview(stackView)
      
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview()
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



