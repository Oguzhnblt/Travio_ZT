//
//  MyVisitsViewCell.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import Foundation
import UIKit
import SnapKit


class MyVisitsViewCell: UICollectionViewCell {
    
    
    static let identifier = "places"
    
    var cellData: Visit? {
        didSet {
            guard let cellData = cellData else { return }

            if let coverImageURL = cellData.place?.cover_image_url {
                imageView.kf.setImage(with: URL(string: coverImageURL))
            } else {
                imageView.image = UIImage(named: "img_default")
            }

            titleLabel.text = cellData.place?.title
            subtitleLabel.text = cellData.place?.place
        }
    }

    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
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
        label.font = AppTheme.getFont(name: .semibold, size: .size30)
        label.textColor = .white
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.getFont(name: .light, size: .size16)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        
        lazy var subtitleStackView = UIStackView(arrangedSubviews: [imageIconView, subtitleLabel])
        subtitleStackView.spacing = 4
        
        lazy var innerStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleStackView])
        innerStackView.axis = .vertical
        innerStackView.spacing = 8
        
        addSubviews(backView)
        backView.addSubview(imageView)
        imageView.addSubview(innerStackView)
        
        backView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        innerStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        imageIconView.snp.makeConstraints({make in
            make.width.equalTo(9)
            make.height.equalTo(18)
        })
        
        dropShadow()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
