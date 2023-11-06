//
//  PlaceTopView.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//
import Foundation
import UIKit
import SnapKit

protocol PlaceTopViewDelegate: AnyObject {
    func placeTopView(_ placeTopView: PlaceTopView, didChangePageTo index: Int)
}

class PlaceTopView: UICollectionViewCell {
    
    weak var delegate: PlaceTopViewDelegate?
    
    static let identifier = "topView"
        
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            delegate?.placeTopView(self, didChangePageTo: currentPage)
        }
    }
    
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
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundStyle = .prominent
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.numberOfPages = newPlacesMockData.count
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView, pageControl)
        
        backView.addSubview(imageView)
        
        backView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(70)
            make.left.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

