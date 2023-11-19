//
//  PopularPlacesTableViewCell.swift
//  Travio
//
//  Created by Oğuz on 30.10.2023.
//

import UIKit
import SnapKit

class GenericPlacesTableViewCell: UITableViewCell {
    
    static let identifier = "popularPlaces"
    private lazy var viewModel = GenericPlacesVM()
    
    func configure(with place: Place) {

        if let urlString = place.cover_image_url, let url = URL(string: urlString), !urlString.isEmpty {
            viewModel.imageCorrect(imageView: imageViews, url: url)
        } else {
            imageViews.image = UIImage(named: "img_default")
        }

        titleLabel.text = place.title
        subtitleLabel.text = place.place
    }

   
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
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
    
    lazy var imageViews: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,]
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private lazy var imageIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_pin_black")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupLayouts()
    }
    
    private func setupLayouts() {
        contentView.addSubview(backView)
        backView.dropShadow()
        backView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(8)
            make.left.right.bottom.equalToSuperview().inset(16)
        })
        let subtitleStackView = UIStackView(arrangedSubviews: [imageIconView, subtitleLabel])
        subtitleStackView.spacing = 6
        
        let innerStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleStackView])
        innerStackView.axis = .vertical
        innerStackView.spacing = 3
        
        let outerStackView = UIStackView(arrangedSubviews: [imageViews, innerStackView])
        outerStackView.alignment = .center
        outerStackView.spacing = 8
        
        backView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageViews.snp.makeConstraints({make in
            make.size.equalTo(90)
        })
        
        imageIconView.snp.makeConstraints({make in
            make.width.equalTo(12)
            make.height.equalTo(18)
        })
        
        
    }
}
