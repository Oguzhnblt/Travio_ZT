//
//  HomeVC.swift
//  Travio
//
//  Created by Oğuz on 25.10.2023.
//

import UIKit
import SnapKit


class HomeVC: UIViewController {
    
    let viewModel = HomeVM()
    var popularPlaces = [Place]()

    let popularPlacesId = "PopularPlacesHeader"
    let newPlacesId = "NewPlacesHeader"
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: "popularPlacesId", withReuseIdentifier: "popularPlaces")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: "newPlacesId", withReuseIdentifier: "newPlaces")
        
        collectionView.register(PlacesCollectionViewCell.self, forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.font = UIFont(name: "Poppins-Regular", size: 20)
        
        return headerLabel
    }()
    
    private lazy var homeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    
    private lazy var homeItemView: UIView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
        
        popularPlacesData()
    }
    
    private func popularPlacesData() {
        viewModel.dataTransfer = { [weak self] place in
            self?.popularPlaces = place
            self?.collectionView.reloadData()
        }
        viewModel.popularPlaces()
    }
   
    private func setupViews() {
        
        self.view.addSubviews(homeView,imageView)
        homeView.addSubview(homeItemView)
        homeItemView.addSubviews(collectionView)
        
        
        setupLayouts()
        
    }
    private func setupLayouts() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints({make in
            make.top.equalTo(homeView).offset(110)
            make.left.equalTo(homeView).offset(16)
        })
        
        homeItemView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(125)
            make.edges.equalToSuperview()
        }
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().offset(0)
        })
        
    }
}

// MARK: -- COLLECTION VİEW

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return popularPlaces.count
            default:
                return popularPlaces.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as! PlacesCollectionViewCell
                
                let object = popularPlaces[indexPath.item]
                cell.configure(with: object)
                
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as! PlacesCollectionViewCell
                
                let object = popularPlaces[indexPath.item]
                cell.configure(with: object)
                return cell
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            
            let sectionTitles = ["Popular Places", "New Places"]
            
            if indexPath.section < sectionTitles.count {
                header.title.text = sectionTitles[indexPath.section]
                
                
                header.button.setTitle("See All", for: .normal)
                header.button.addTarget(self, action: #selector(seeAllPopular), for: .touchUpInside)
                
            } else {
                header.title.text = "Unknown Section"
                header.button.setTitle("See All", for: .normal)
                header.button.addTarget(self, action: #selector(seeAllDefault), for: .touchUpInside)
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
    @objc func seeAllPopular() {
        let seeAllVC = PopularPlacesVC()
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    @objc func seeAllNew() {
        print( "Handle the action for See All New")
        
    }
    
    @objc func seeAllDefault() {
        print( "Handle the action for See All Default")
        
    }
}


extension HomeVC {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
                case 0:
                    return HomePageLayout.shared.makePlacesLayout()
                default:
                    return HomePageLayout.shared.makePlacesLayout()
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


