//
//  HomeCell.swift
//  Travio
//
//  Created by Oğuz on 25.10.2023.
//
import UIKit

class HomeCell: UICollectionViewCell {
    
     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        addSubviews(imageView,titleLabel,subtitleLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 280, height: 178)
        imageView.roundAllCorners(radius: 18)
        
        titleLabel.frame = CGRect(x: 16, y: 120, width: 280, height: 30)
        subtitleLabel.frame = CGRect(x: 16, y: 150, width: 280, height: 20)
    }
}

