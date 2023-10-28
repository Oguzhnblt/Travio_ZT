//
//  PlacesCollectionViewCell.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation
import UIKit

class PlacesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "places"
    
    // Section içindeki item değişimini dinlemek için
    var cellData: PopularPlacesModel? {
        didSet {
            guard let cellData = cellData else {
                return
            }
            imageView.image = UIImage(named: cellData.covere_img_url ?? "img_default")
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
        addSubviews(imageView,titleLabel,subtitleLabel, imageIconView)
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: 280, height: 178)
        imageView.roundAllCorners(radius: 20)
        
        titleLabel.frame = CGRect(x: 16, y: 120, width: 280, height: 30)
        
        imageIconView.frame = CGRect(x: 16, y: 153, width: 9, height: 12)
        subtitleLabel.frame = CGRect(x: 31, y: 150, width: 280, height: 21)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
