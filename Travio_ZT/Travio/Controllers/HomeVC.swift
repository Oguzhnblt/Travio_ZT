//
//  HomeVC.swift
//  Travio
//
//  Created by Oğuz on 25.10.2023.
//

import UIKit
import SnapKit


class HomeVC: UIViewController  {
    
    let popularPlacesId = "PopularPlacesHeader"
    let newPlacesId = "NewPlacesHeader"
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let lay = createCompositionalLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        collectionView.backgroundColor = .clear
        
        collectionView.register(PlacesCollectionViewCell.self, forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
        
        collectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: popularPlacesId, withReuseIdentifier: "popularPlaces")
        collectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: newPlacesId, withReuseIdentifier: "newPlaces")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Popular Places"
        headerLabel.textColor = .black
        headerLabel.font = UIFont(name: "Poppins-Regular", size: 20)
        
        return headerLabel
    }()
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    
    private lazy var loginItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "homePage_icon")
        
        return imageView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    var addButtonTappedAction: (() -> Void)?
    
    
    @objc  func addButtonTapped() {
        addButtonTappedAction?()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addButtonTappedAction = {
            print("Button tapped")
        }
    }
    
    private func setupViews() {
        
        self.view.addSubviews(loginView,imageView)
        loginView.addSubview(loginItemView)
        loginItemView.addSubviews(collectionView,addButton)
        
        setupLayouts()
        
    }
    
    private func setupLayouts() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints({make in
            make.top.equalTo(loginView).offset(43)
            make.left.equalTo(loginView).offset(16)
        })
        
        loginItemView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(125)
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
            make.left.right.equalTo(loginView).inset(24)
        })
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().offset(55)
        }
    }
}

// MARK: -- COLLECTION VİEW

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    // Her bir item'in boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 // Section sayısı
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 1:
                return popularPlacesMockData.count
            default:
                return popularPlacesMockData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as! PlacesCollectionViewCell
        cell.cellData = popularPlacesMockData[indexPath.row]
        return cell
        
    }
    
    
    
    // Header Title eklemek için
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseIdentifier: String
        let title: String
        
        switch kind {
            case popularPlacesId:
                reuseIdentifier = "popularPlaces"
                title = "Popular Places"
                
            case newPlacesId:
                reuseIdentifier = "newPlaces"
                title = "New Places"
                
            default:
                return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryHeaderView
        
        headerView.titleLabel.text = title
        return headerView
        
    }
}


extension HomeVC {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [self] (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
                case 0:
                    return HomePageLayout.shared.makePlacesLayout(elementKind: popularPlacesId)
                case 1:
                    return HomePageLayout.shared.makePlacesLayout(elementKind: newPlacesId)
                default:
                    return HomePageLayout.shared.makePlacesLayout(elementKind: popularPlacesId)
            }
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View{
        
        HomeVC().showPreview()
    }
}
#endif
