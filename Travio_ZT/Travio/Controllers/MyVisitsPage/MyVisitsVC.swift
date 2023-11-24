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
    var myVisits: [Visit] = []
    private lazy var viewModel = MyVisitsVM()
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myVisitsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "contentColor")
        collectionView.register(MyVisitsViewCell.self, forCellWithReuseIdentifier: MyVisitsViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Henüz ziyaret edilen yer yok."
        label.textColor = .gray
        label.font = AppTheme.getFont(name: .regular, size: .size14)
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {

        viewModel.visitsTransfer = { [weak self] visits in
            self?.myVisits = visits
            self?.collectionView.reloadData()
            self?.noDataLabel.isHidden = ((self?.myVisits.isEmpty) != nil)
        }
        
        viewModel.getAllVisits()
    }
    
    private func setupViews() {
        setupView(title: "My Visits", buttonImage: nil, buttonPosition: nil, headerLabelPosition: .left, buttonAction: nil, itemsView: [collectionView])
        view.addSubviews(noDataLabel)
        setupLayouts()
        
    }
    
    private func setupLayouts() {
        noDataLabel.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        })
    }
}

// MARK: -- COLLECTION VİEW

extension MyVisitsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension MyVisitsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myVisits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyVisitsViewCell.identifier, for: indexPath) as! MyVisitsViewCell
        cell.cellData = myVisits[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeDetailsVC = PlaceDetailsVC()
        placeDetailsVC.selectedPlace = myVisits[indexPath.item].place
        navigationController?.pushViewController(placeDetailsVC, animated: true)
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
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 55, leading: 0, bottom: 20, trailing: 0)
        
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


