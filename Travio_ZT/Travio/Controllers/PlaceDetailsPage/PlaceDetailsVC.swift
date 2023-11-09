//
//  PlaceDetailsVC.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import MapKit

class PlaceDetailsVC: UIViewController, UICollectionViewDelegate {
    
    var selectedPlace: Place?
    
    private lazy var isBookmarked = true

    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PlaceDetailsLayout.shared.placeDetailsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(PlaceTopView.self, forCellWithReuseIdentifier: PlaceTopView.identifier)
        collectionView.register(PlaceBottomView.self, forCellWithReuseIdentifier: PlaceBottomView.identifier)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 1 // FIXME: Fotoğraf sayısına göre düzeltilecek
        pageControl.backgroundStyle = .prominent
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        return pageControl
    }()
    
    @objc private func pageControlValueChanged() {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_bookmark"), for: .normal)
        button.addTarget(self, action: #selector(bookMarkTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func bookMarkTapped() {
        isBookmarked.toggle()
        
        if isBookmarked {
            print("Item removed from bookmarks!")
            
        } else {
            print("Item bookmarked!")
            
        }
        
        let image = isBookmarked ? UIImage(named: "icon_bookmark") : UIImage(named: "icon_bookmark_fill")
        bookmarkButton.setImage(image, for: .normal)
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "img_place_back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubviews(collectionView, pageControl, bookmarkButton, backButton)
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        collectionView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(-100)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        bookmarkButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.right.equalToSuperview().offset(-30)
        })
        
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.left.equalToSuperview().offset(24)
        })
        
        pageControl.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(self.view.frame.height * 0.23)
            make.left.right.equalToSuperview()
        })
    }
    
    
}

extension PlaceDetailsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1 // FIXME: Düzeltilecek
            case 1:
                return 1
            default:
                return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceTopView.identifier, for: indexPath) as! PlaceTopView
                
                if let selectedPlace = selectedPlace,
                          let coverImageURLString = selectedPlace.cover_image_url,
                          let url = URL(string: coverImageURLString) {
                           cell.imageView.kf.setImage(with: url)
                    print(url)
                       }
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceBottomView.identifier, for: indexPath) as! PlaceBottomView
                
                if let selectedPlace = selectedPlace {
                    cell.placeTitle.text = selectedPlace.place
                    cell.descriptionLabel.text = selectedPlace.description
                    cell.authorTitle.text = selectedPlace.creator
                    
                    
                    if let formattedDate = DateFormatter.formattedDate(from: selectedPlace.created_at!, originalFormat: FormatType.longFormat.rawValue , targetFormat: FormatType.stringFormat.rawValue, localeIdentifier: "tr_TR") {
                        cell.dateTitle.text = formattedDate
                    }

                    let targetCoordinate = CLLocationCoordinate2D(latitude: selectedPlace.latitude!, longitude: selectedPlace.longitude!)
                    
                    let region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    
                    cell.mapView.setCenter(targetCoordinate, animated: false)
                    cell.mapView.region = region
                }
                return cell
                
            default:
                fatalError("Unexpected section")
        }
    }
}

extension PlaceDetailsVC {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        if let firstIndex = visibleIndexPaths.first {
            pageControl.currentPage = firstIndex.item
        }
    }
}



#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PlaceDetailsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        PlaceDetailsVC().showPreview()
    }
}
#endif

