//
//  PlacesCollectionViewCell.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation
import UIKit
import SnapKit

class PlacesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "places"
    
    // Section içindeki item değişimini dinlemek için
    var cellData: PlacesModel? {
        didSet {
            guard let cellData = cellData else {
                return
            }
            imageView.image = UIImage(named: cellData.cover_img_url ?? "img_default")
            titleLabel.text = cellData.title
            subtitleLabel.text = cellData.place
        }
    }
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 16
        backView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        return backView
    }()

     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
   private lazy var imageIconView: UIImageView = {
        let imageIconView = UIImageView()
        imageIconView.contentMode = .scaleAspectFit
        imageIconView.image = .imgPin
        return imageIconView
    }()
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        backView.addSubviews(imageView,titleLabel,subtitleLabel,imageIconView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-60)
            make.left.equalToSuperview().offset(16)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().offset(31)

        }
        
        imageIconView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(16)

        }

    }

        
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
