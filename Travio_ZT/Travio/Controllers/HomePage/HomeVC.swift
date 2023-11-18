//
//  HomeVC.swift
//  Travio
//
//  Created by Oğuz on 25.10.2023.
//

import UIKit
import SnapKit


class HomeVC: UIViewController {
    
    private lazy var viewModel = HomeVM()
    private lazy var popularPlaces = [Place]()
    private lazy var lastPlaces = [Place]()

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
        
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
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
        lastPlacesData()
        popularPlacesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let addNewPlace = AddNewPlaceVC()
        addNewPlace.completedAddPlace = {
            self.collectionView.reloadData()
        }
    }
    
    private func popularPlacesData() {
        viewModel.popularPlacesTransfer = { [weak self] place in
            self?.popularPlaces = place
            self?.collectionView.reloadData()
        }
        viewModel.popularPlaces()
    }
    
    private func lastPlacesData() {
        viewModel.lastPlacesTransfer = { [weak self] place in
            self?.lastPlaces = place
            self?.collectionView.reloadData()
        }
        viewModel.newPlaces()
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
            make.top.equalTo(homeView).offset(80)
            make.left.equalTo(homeView).offset(16)
        })
        
        homeItemView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(125)
            make.edges.equalToSuperview()
        }
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
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
            case 1:
                return lastPlaces.count
            default:
                fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
                
                let object = popularPlaces[indexPath.item]
                cell.configurePlaces(with: object)
                
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
                
                let object = lastPlaces[indexPath.item]
                cell.configurePlaces(with: object)
                return cell
            default:
                fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeDetailsVC = PlaceDetailsVC()  
        
        switch indexPath.section {
        case 0:
            placeDetailsVC.selectedPlace = popularPlaces[indexPath.item]
        case 1:
            placeDetailsVC.selectedPlace = lastPlaces[indexPath.item]
        default:
            break
        }
        
        navigationController?.pushViewController(placeDetailsVC, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            
            let sectionTitles = ["Popular Places", "New Places"]
            
            if indexPath.section < sectionTitles.count {
                header.title.text = sectionTitles[indexPath.section]
                header.button.setTitle("See All", for: .normal)
                switch indexPath.section {
                    case 0:
                        header.button.addTarget(self, action: #selector(seeAllPopular), for: .touchUpInside)
                    case 1:
                        header.button.addTarget(self, action: #selector(seeAllNew), for: .touchUpInside)
                    default:
                        break
                }
            }
            return header
        }
        return UICollectionReusableView()
    }

    @objc func seeAllPopular() {
        let popularPlacesVC = GenericPlacesVC()
        popularPlacesVC.title = "Popular Places"
        popularPlacesVC.isPopular = true
        popularPlacesVC.fetchData()
        navigationController?.pushViewController(popularPlacesVC, animated: true)
    }

    @objc func seeAllNew() {
        let newPlacesVC = GenericPlacesVC()
        newPlacesVC.title = "New Places"
        newPlacesVC.isPopular = false
        newPlacesVC.fetchData()
        navigationController?.pushViewController(newPlacesVC, animated: true)
    }
}

extension HomeVC {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
                case 0,1:
                    return HomePageLayout.shared.makePlacesLayout()
                default:
                    fatalError()
            }
        }
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View{
        
        HomeVC().showPreview().ignoresSafeArea()
    }
}
#endif


