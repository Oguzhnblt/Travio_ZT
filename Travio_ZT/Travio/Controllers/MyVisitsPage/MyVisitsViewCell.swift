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

     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        
        let iconSubtitleStackView = UIStackView(arrangedSubviews: [imageIconView, subtitleLabel])
        iconSubtitleStackView.axis = .horizontal
        iconSubtitleStackView.spacing = 0
        iconSubtitleStackView.alignment = .center

        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, iconSubtitleStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 0

        addSubviews(imageView, verticalStackView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-30)
        }
    }


    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
