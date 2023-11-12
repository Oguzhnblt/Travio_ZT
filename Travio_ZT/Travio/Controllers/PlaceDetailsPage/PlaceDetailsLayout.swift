//
//  PlaceLayout.swift
//  Travio
//
//  Created by Oğuz on 9.11.2023.
//

import Foundation
import UIKit

class PlaceDetailsLayout {
    static let shared = PlaceDetailsLayout()
    
     func placeDetailsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.makeLayout(for: sectionNumber)
        }
    }
    
     func makeLayout(for section: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        var layoutGroupSize: NSCollectionLayoutSize
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
        
        switch section {
            case 0:
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
                orthogonalScrollingBehavior = .groupPagingCentered
            case 1:
                layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55))
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
