//
//  MyAddedPlacesVC.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import UIKit
import SnapKit

class MyAddedPlacesVC: UIViewController {
    
    private lazy var viewModel = MyAddedPlacesVM()
    private var myAddedPlaces: [Place] = []
    private var isSorted = true
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: myAddedlayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(MyAddedPlacesViewCell.self, forCellWithReuseIdentifier: MyAddedPlacesViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var sortButton: UIButton = {
        let sort = UIButton(type: .custom)
        sort.setImage(UIImage(named: "img_a_z"), for: .normal)
        sort.addTarget(self, action: #selector(sortDown), for: .touchUpInside)
        
        
        return sort
    }()
    
    
    @objc func sortDown() {
        isSorted.toggle()
        
        let imageName = isSorted ? "img_a_z" : "img_z_a"
        sortButton.setImage(UIImage(named: imageName), for: .normal)
        
        if isSorted {
            myAddedPlaces.sort { $0.title!.localizedCompare($1.title!) == .orderedAscending }
        } else {
            myAddedPlaces.sort { $0.title!.localizedCompare($1.title!) == .orderedDescending }
        }
        
        collectionView.reloadData()
    }

    
    
    private func myAdded() {
        viewModel.myAddedTransfer = { [weak self] myAdded in
            self?.myAddedPlaces = myAdded
            self?.collectionView.reloadData()
        }
        viewModel.getMyAddedPlaces()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        myAdded()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setupViews() {
        setupView(title: "My Added Places",buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [collectionView, sortButton])
        
        setupLayouts()
        
    }
    
    private func setupLayouts() {
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(50)
            make.left.right.bottom.equalToSuperview().inset(16)
            
        })
        sortButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-69)
            make.top.equalToSuperview().offset(20)
        })
        
        
    }
}

extension MyAddedPlacesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAddedPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyAddedPlacesViewCell.identifier, for: indexPath) as! MyAddedPlacesViewCell
        
        cell.cellData = myAddedPlaces[indexPath.row]
        
        return cell
    }
}

extension MyAddedPlacesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = PlaceDetailsVC()
        
        detailsVC.selectedPlace = myAddedPlaces[indexPath.item]
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


extension MyAddedPlacesVC {
    
    private func myAddedlayout() -> UICollectionViewCompositionalLayout {
        let section = myAddedPlacesLayout()
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    private func myAddedPlacesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.3))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
        layoutSection.orthogonalScrollingBehavior  = .none
        
        return layoutSection
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct MyAddedPlaces_Preview: PreviewProvider {
    static var previews: some View {
        MyAddedPlacesVC().showPreview().ignoresSafeArea()
    }
}
#endif

