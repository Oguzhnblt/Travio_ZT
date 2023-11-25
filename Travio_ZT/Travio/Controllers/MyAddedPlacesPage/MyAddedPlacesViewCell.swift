//
//  MyAddedPlacesCell.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import UIKit
import SnapKit
import UIKit

class MyAddedPlacesViewCell: UICollectionViewCell {
    
    static let identifier = "myAddedCell"
    
    var cellData: Place? {
        didSet {
            guard let cellData = cellData else { return }

            if let coverImageURL = cellData.cover_image_url {
                imageView.kf.setImage(with: URL(string: coverImageURL))
            } else {
                imageView.image = UIImage(named: "img_default")
            }

            titleLabel.text = cellData.title
            subtitleLabel.text = cellData.place
        }
    }
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = AppTheme.getColor(name: .content)
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.getFont(name: .semibold, size: .size24)
        label.textColor = AppTheme.getColor(name: .general)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.getFont(name: .light, size: .size14)
        label.textColor = AppTheme.getColor(name: .general)
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var imageIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_pin_black")
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
