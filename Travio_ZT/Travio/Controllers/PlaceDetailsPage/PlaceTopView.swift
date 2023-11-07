//
//  PlaceTopView.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//
import Foundation
import UIKit
import SnapKit

class PlaceTopView: UICollectionViewCell {
    
    static let identifier = "topView"
        
    var cellData: PlacesModel? {
        didSet {
            guard let cellData = cellData else {
                return
            }
            imageView.image = UIImage(named: cellData.cover_img_url ?? "img_default")
        }
    }
   
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        
        backView.addSubview(imageView)
        
        backView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

