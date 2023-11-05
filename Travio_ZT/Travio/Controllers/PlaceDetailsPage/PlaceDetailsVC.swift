//
//  PlaceDetailsVC.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import Foundation
import UIKit
import SnapKit

class PlaceDetailsVC: UIViewController, UICollectionViewDelegate {
    
    
    private lazy var topCollectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myVisitsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(PlaceTopView.self, forCellWithReuseIdentifier: PlaceTopView.identifier)
        collectionView.register(PlaceBottomView.self, forCellWithReuseIdentifier: PlaceBottomView.identifier)

        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = newPlacesMockData.count
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        
        return pageControl
    }()
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        let indexPath = IndexPath(item: selectedPage, section: 0)
        topCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubviews(topCollectionView, pageControl)
        
        
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        topCollectionView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        })
        
        pageControl.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(250)
            make.left.equalToSuperview().offset(120)
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
                return newPlacesMockData.count
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
                cell.cellData = newPlacesMockData[indexPath.row]
                return cell
            case 1:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceBottomView.identifier, for: indexPath) as! PlaceBottomView
                cell.placeTitle.text = "İstanbul"
                cell.dateTitle.text = "22 Eylül 2023"
                cell.authorTitle.text = "by @oguzhanbolat"
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


extension PlaceDetailsVC {
    
    private func myVisitsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.myVisitsLayouts()
        }
    }
    
    private func myVisitsLayouts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        return layoutSection
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

