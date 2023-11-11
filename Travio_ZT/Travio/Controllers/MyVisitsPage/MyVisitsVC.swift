//
//  MyVisitsVC.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import Foundation
import UIKit
import SnapKit

class MyVisitsVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myVisitsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
 
        collectionView.register(MyVisitsViewCell.self, forCellWithReuseIdentifier: MyVisitsViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .white
        headerLabel.text = "My Visits"
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()

    
    private lazy var myVisitsItemView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        self.view.addSubviews(headerLabel,myVisitsItemView)
        myVisitsItemView.addSubviews(collectionView)
        
        
        setupLayouts()
        
    }
    
    private func setupLayouts() {
     
        myVisitsItemView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.left.right.bottom.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
            make.left.equalToSuperview().offset(24)
        })
        
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(myVisitsItemView.snp.top)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        })
    }
}

// MARK: -- COLLECTION VİEW
extension MyVisitsVC: UICollectionViewDelegateFlowLayout {
    
    // Her bir item'in boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension MyVisitsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularPlacesMockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyVisitsViewCell.identifier, for: indexPath) as! MyVisitsViewCell
        cell.cellData = popularPlacesMockData[indexPath.row]
        return cell
        
    }
}


extension MyVisitsVC {
    
   private func myVisitsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.myVisitsLayouts()
        }
    }
    
    private func myVisitsLayouts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)


        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .none
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 45, leading: 0, bottom: 0, trailing: 0)

        layoutSection.interGroupSpacing = 16

        return layoutSection
    }

}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MyVisitsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        MyVisitsVC().showPreview()
    }
}
#endif


