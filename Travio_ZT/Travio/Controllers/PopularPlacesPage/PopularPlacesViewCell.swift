//
//  PopularPlacesViewCell.swift
//  Travio
//
//  Created by Oğuz on 30.10.2023.
//

import UIKit
import SnapKit

class PopularPlacesViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .content
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Thin", size: 14)
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var imageIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPinBlack
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupviews()
    }
    
    private func setupviews() {
        setupLayouts()
    }
    
    private func setupLayouts() {
        contentView.addSubview(backView)
        
        backView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(55)
            make.left.right.equalToSuperview().inset(16)
        })
        
        lazy var subtitleStackView = UIStackView(arrangedSubviews: [imageIconView, subtitleLabel])
        subtitleStackView.spacing = 6
        
        lazy var innerStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleStackView])
        innerStackView.axis = .vertical
        innerStackView.spacing = 3
        
        lazy var outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView])
        outerStackView.alignment = .center
        outerStackView.spacing = 8
        
        backView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints({make in
            make.size.equalTo(90)
        })
        
        imageIconView.snp.makeConstraints({make in
            make.width.equalTo(12)
            make.height.equalTo(18)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
