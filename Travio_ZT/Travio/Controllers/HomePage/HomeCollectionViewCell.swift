//
//  PlacesCollectionViewCell.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "places"
    private lazy var viewModel = HomeVM()
    
    func configurePlaces(with place: Place) {
        imageView.kf.indicatorType = .activity
        
        guard let urlString = place.cover_image_url, let url = URL(string: urlString), !urlString.isEmpty else {
            imageView.image = UIImage(named: "img_default")
            return
        }

        imageView.kf.setImage(with: url, placeholder: UIImage(named: "img_default"), options: [.transition(.flipFromLeft(0.5))])
        titleLabel.text = place.title
        subtitleLabel.text = place.place
    }

    private lazy var backView: UIView = {
        let backView = UIView()
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 16
        return backView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var imageIconView: UIImageView = {
        let imageIconView = UIImageView()
        imageIconView.contentMode = .scaleAspectFit
        imageIconView.image = UIImage(named: "img_pin")
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
        backView.dropShadow()
        backView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
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
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
