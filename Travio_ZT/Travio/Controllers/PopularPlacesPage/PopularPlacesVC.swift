//
//  PopularPlacesVC.swift
//  Travio
//
//  Created by Oğuz on 30.10.2023.
//

import UIKit
import SnapKit

class PopularPlacesVC: UIViewController {
    
    let viewModel = PopularPlacesVM()
    var popularPlaces = [Place]()
    
    private var isSorted = false
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: popularPlacesLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(PopularPlacesViewCell.self, forCellWithReuseIdentifier: "popularCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var sortButton: UIButton = {
        let sort = UIButton(type: .custom)
        sort.setImage(UIImage(named: "img_down_sort"), for: .normal)
        sort.addTarget(self, action: #selector(sortDown), for: .touchUpInside)
        
        
        return sort
    }()
  
    // MARK: Sorting
    
    @objc func sortDown() {
        isSorted.toggle()
        
        let imageName = isSorted ? "img_up_sort" : "img_down_sort"
        sortButton.setImage(UIImage(named: imageName), for: .normal)
        
        if isSorted {
            popularPlaces.sort { $0.title!.localizedCompare($1.title!) == .orderedAscending }
        } else {
            popularPlaces.sort { $0.title!.localizedCompare($1.title!) == .orderedDescending }
        }
        
        collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
        popularPlacesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func popularPlacesData() {
        viewModel.dataTransfer = { [weak self] place in
            self?.popularPlaces = place
            self?.collectionView.reloadData()
        }
        viewModel.popularPlaces(limit: 10)
    }
    
    
    
    
    private func setupViews() {
        
        setupView(title: "Popular Places",buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [collectionView, sortButton])

        setupLayouts()
        
    }
    
    private func setupLayouts() {
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview().offset(35)
            make.left.right.equalToSuperview().inset(8)

        })
        
        sortButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-69)
            make.top.equalToSuperview().offset(24)
        })
        
        
    }
}

extension PopularPlacesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension PopularPlacesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularPlacesViewCell
        
        let object = popularPlaces[indexPath.item]
        cell.configure(with: object)
      
        return cell
    }
}

extension PopularPlacesVC {
    
    func popularPlacesLayout() -> UICollectionViewCompositionalLayout {
        let section = popularPlacesLayouts()
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func popularPlacesLayouts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.3))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior  = .none
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 90, trailing: 0)
        
        return layoutSection
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct PopularPlacesVC_Preview: PreviewProvider {
    static var previews: some View {
        PopularPlacesVC().showPreview()
    }
}
#endif

