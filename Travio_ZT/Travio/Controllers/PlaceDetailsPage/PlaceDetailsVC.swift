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
    var imageURLs: [String] = []
    var selectedCoordinates: CLLocationCoordinate2D?
    
    
    private lazy var viewModel = PlaceDetailsVM()
    
    private lazy var isBookmarked = false
    
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
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "img_place_back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
            let formattedDate = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime, .withFractionalSeconds])
            
            let params = ["place_id": selectedPlace?.id, "visited_at": formattedDate]
            viewModel.postVisit(params: params)
            
        } else {
            viewModel.deleteVisit(placeID: selectedPlace?.id)
        }
        
        let image = isBookmarked ? UIImage(named: "icon_bookmark_fill") : UIImage(named: "icon_bookmark")
        bookmarkButton.setImage(image, for: .normal)
    }
    
    
    
    private func checkBookmark() {
        guard let placeID = selectedPlace?.id else { return }
        
        viewModel.checkVisitsById(placeID: placeID)
        viewModel.checking = { [weak self] status in
            guard let self = self else { return }
            
            self.isBookmarked = (status == "success")
            
            
            let bookmarkImage = self.isBookmarked ? UIImage(named: "icon_bookmark_fill") : UIImage(named: "icon_bookmark")
            self.bookmarkButton.setImage(bookmarkImage, for: .normal)
        }
    }
    
  
    private func galleryImages() {
        guard let placeId = selectedPlace?.id  else {return}
        
        viewModel.getAllGalleries(placeId: placeId)
        viewModel.imageData = { [weak self] placeImages in
            guard let self = self else { return }
            
            if placeImages.isEmpty {
                self.setDefaultImage()
            } else {
                let imageURLs = placeImages.compactMap { $0.image_url }
                self.imageURLs.append(contentsOf: imageURLs)
                
                self.pageControl.numberOfPages = self.imageURLs.count
                self.collectionView.reloadData()
            }
        }
    }
    
    
    private func setDefaultImage() {
        let defaultImageURL = "https://www.simurgtakip.com/wp-content/uploads/2015/08/default_image_01.png"
        self.imageURLs = [defaultImageURL]
        self.pageControl.numberOfPages = 1
        self.collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        galleryImages()
        checkBookmark()
        
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
                return imageURLs.count
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
                
                if indexPath.row < imageURLs.count {
                    
                    let imageURLString = imageURLs[indexPath.row]
                    if let url = URL(string: imageURLString) {
                        cell.imageView.kf.setImage(with: url)
                    }
                }
                
                return cell
                
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceBottomView.identifier, for: indexPath) as! PlaceBottomView
                
                if let selectedLocation = selectedPlace {
                    cell.placeTitle.text = selectedLocation.place
                    cell.descriptionLabel.text = selectedLocation.description
                    cell.authorTitle.text = selectedLocation.creator
                    
                    if let formattedDate = DateFormatter.formattedDate(from: selectedLocation.created_at!, originalFormat: FormatType.longFormat.rawValue, targetFormat: FormatType.stringFormat.rawValue, localeIdentifier: "tr_TR") {
                        cell.dateTitle.text = formattedDate
                    }
                    
                    let targetCoordinate = CLLocationCoordinate2D(latitude: selectedLocation.latitude!, longitude: selectedLocation.longitude!)
                    let region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    
                    cell.mapView.setCenter(targetCoordinate, animated: false)
                    cell.mapView.region = region
                    
                    let annotation = MapAnnotation(coordinate: targetCoordinate, image: UIImage(named: "icon_map_mark"))
                    cell.mapView.addAnnotation(annotation)
                
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

