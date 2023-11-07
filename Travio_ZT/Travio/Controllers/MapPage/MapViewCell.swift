//
//  MapViewCell.swift
//  Travio
//
//  Created by web3406 on 7.11.2023.
//

import Foundation
import UIKit
import SnapKit


class MapViewCell: UICollectionViewCell {
    
    
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
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
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
        imageIconView.sizeThatFits(CGSize(width: 9, height: 12))
        imageIconView.image = UIImage(named: "imgPin")
        return imageIconView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 24)
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
        
        lazy var subtitleStackView = UIStackView(arrangedSubviews: [imageIconView, subtitleLabel])
        subtitleStackView.spacing = 4
        
        lazy var innerStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleStackView])
        innerStackView.axis = .horizontal
        innerStackView.spacing = 8
        
        addSubviews(backView)
        backView.addSubview(imageView)
        imageView.addSubview(innerStackView)
        
        backView.dropShadow()
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
            make.height.equalTo(12)
        })
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}


