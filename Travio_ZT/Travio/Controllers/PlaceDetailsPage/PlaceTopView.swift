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
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor(hex: "#333333").withAlphaComponent(0)
        let endColor = UIColor(hex: "#F8F8F8").withAlphaComponent(1)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.8, 1]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        imageView.layer.addSublayer(gradientLayer)

        backView.addSubviews(imageView)
        
        backView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: bounds.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
