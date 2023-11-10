//
//  AddPhotoCell.swift
//  Travio
//
//  Created by Oğuz on 10.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddPhotoCell: UICollectionViewCell {
    static let identifier = "photoCell"
    
    private lazy var backView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "img_addPhoto")
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
        addSubview(backView)
        backView.addSubview(imageView)
        
        backView.snp.makeConstraints({make in
            make.left.right.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview()
        })

        
        imageView.snp.makeConstraints({make in
            make.center.equalToSuperview()
        })
        
        dropShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
