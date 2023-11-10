//
//  AddNewPlaceLayout.swift
//  Travio
//
//  Created by Oğuz on 10.11.2023.
//

import UIKit
class AddNewPlaceLayout {
    static let shared = AddNewPlaceLayout()
    
    func makePlacesLayout(forSection section: Int) -> NSCollectionLayoutSection {
        var layoutItem: NSCollectionLayoutItem
        var layoutGroupSize: NSCollectionLayoutSize
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
        
        switch section {
            case 0:
                layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.25))
                orthogonalScrollingBehavior = .none
            case 1:
                layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
                orthogonalScrollingBehavior = .none
            case 2:
                layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.25))
                orthogonalScrollingBehavior = .none
            case 3:
                layoutItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.65))
                orthogonalScrollingBehavior = .groupPaging
            default:
                fatalError()
        }
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 0, trailing: 16)
        
        return layoutSection
    }
    
}
