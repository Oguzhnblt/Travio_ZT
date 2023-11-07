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
    
    let placeTopView = PlaceTopView()
    
    
    private lazy var collectionView: UICollectionView = {
        
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubviews(collectionView)
        
        
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        collectionView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview().offset(-60)
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
                cell.authorTitle.text = "by added @oguzhanbolat"
                return cell
                
            default:
                fatalError("Unexpected section")
        }
    }
}

extension PlaceDetailsVC {
    
    private func myVisitsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.myVisitsLayouts(for: sectionNumber)
        }
    }
    
    private func myVisitsLayouts(for section: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        var layoutGroupSize: NSCollectionLayoutSize
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
        
        switch section {
            case 0:
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
                orthogonalScrollingBehavior = .groupPagingCentered
            case 1:
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
                orthogonalScrollingBehavior = .none
            default:
                Swift.fatalError("Unexpected section: \(section)")
        }
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        
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

