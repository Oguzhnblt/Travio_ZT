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
    
    static let reuseIdentifier = "SecuritySettingsHeaderView"
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(title)
        setupLayouts()
    }
    
    private func setupLayouts() {
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().offset(25)
        }
    }
}
