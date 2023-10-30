//
//  CategoryHeaderView.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
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
        
        button.setTitleColor(.background, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        
        
        let stackView = UIStackView(arrangedSubviews: [title ,separator, button])
        stackView.axis = .horizontal
        stackView.spacing = 16
        addSubview(stackView)
      
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().offset(25)
        }
        
        button.snp.makeConstraints({make in
        
            make.left.equalTo(title.snp.left).offset(300)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        })
        
      
    }
    
    @objc func btns() {
     print("tIKLANDI")
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



