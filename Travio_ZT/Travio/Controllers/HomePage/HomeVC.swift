//
//  HomeVC.swift
//  Travio
//
//  Created by Oğuz on 25.10.2023.
//

import UIKit
import SnapKit

enum SectionType: Int, CaseIterable {
    case popularPlaces
    case newPlaces
    case myAddedPlaces

    func title() -> String {
        switch self {
        case .popularPlaces:
            return "Popular Places"
        case .newPlaces:
            return "New Places"
        case .myAddedPlaces:
            return "My Added Places"
        }
    }
}


class HomeVC: UIViewController {
    
    weak var previousViewController: UIViewController?
    private lazy var viewModel = HomeVM()
    
    private lazy var popularPlaces = [Place]()
    private lazy var lastPlaces = [Place]()
    private lazy var myAddedPlaces = [Place]()

    let popularPlacesId = "PopularPlacesHeader"
    let newPlacesId = "NewPlacesHeader"
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: popularPlacesId, withReuseIdentifier: popularPlacesId)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: newPlacesId, withReuseIdentifier: newPlacesId)

        
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previousViewController = nil

        let addNewPlace = AddNewPlaceVC()
        addNewPlace.completedAddPlace = { [weak self] in
            self?.collectionView.reloadData()
        }
        lastPlacesData()
        popularPlacesData()
        myAddedPlacesData()
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
    
    private func myAddedPlacesData() {
        viewModel.addedPlacesTransfer = { [weak self] place in
            self?.myAddedPlaces = place
            self?.collectionView.reloadData()
        }
        viewModel.myAddedPlaces()
    }
   
    private func setupViews() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        self.view.addSubviews(homeItemView,imageView)
        homeItemView.addSubviews(collectionView)
        
        setupLayouts()
        
    }
    private func setupLayouts() {
        homeItemView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(35)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(16)
        })
        
       
        collectionView.snp.makeConstraints({make in
            make.top.equalToSuperview()
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
        return SectionType.allCases.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {return 0}

        switch sectionType {
            case .popularPlaces:
                return popularPlaces.count
            case .newPlaces:
                return lastPlaces.count
            case .myAddedPlaces:
                return myAddedPlaces.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            fatalError("Invalid section type")
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell

        switch sectionType {
            case .popularPlaces:
                cell.configurePlaces(with: popularPlaces[indexPath.item])
            case .newPlaces:
                cell.configurePlaces(with: lastPlaces[indexPath.item])
            case .myAddedPlaces:
                cell.configurePlaces(with: myAddedPlaces[indexPath.item])
        }

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            fatalError("Invalid section type")
        }

        let placeDetailsVC = PlaceDetailsVC()
        placeDetailsVC.previousViewController = self



        switch sectionType {
            case .popularPlaces:
                placeDetailsVC.selectedPlace = popularPlaces[indexPath.item]
            case .newPlaces:
                placeDetailsVC.selectedPlace = lastPlaces[indexPath.item]
            case .myAddedPlaces:
                placeDetailsVC.selectedPlace = myAddedPlaces[indexPath.item]
        }

        navigationController?.pushViewController(placeDetailsVC, animated: true)
    }


    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            
            let sectionTitles = ["Popular Places", "New Places", "My Added Places"]
            
            if indexPath.section < sectionTitles.count {
                let sectionType = SectionType(rawValue: indexPath.section)!
                
                header.title.text = sectionTitles[indexPath.section]
                header.button.setTitle("See All", for: .normal)
                
                header.button.tag = sectionType.rawValue
                header.button.addTarget(self, action: #selector(seeAll(_:)), for: .touchUpInside)
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }


    @objc func seeAll(_ sender: UIButton) {
        guard let sectionType = SectionType(rawValue: sender.tag) else {
            return
        }
        
        lazy var genericPlacesVC = GenericPlacesVC()
        genericPlacesVC.previousViewController = self
        
        switch sectionType {
            case .popularPlaces:
                genericPlacesVC.title = sectionType.title()
                genericPlacesVC.sectionType = .popularPlaces
            case .newPlaces:
                genericPlacesVC.title =  sectionType.title()
                genericPlacesVC.sectionType = .newPlaces
            case .myAddedPlaces:
                genericPlacesVC.title =  sectionType.title()
                genericPlacesVC.sectionType = .myAddedPlaces
        }
        
        genericPlacesVC.fetchData()
        navigationController?.pushViewController(genericPlacesVC, animated: true)
    }
    
}

extension HomeVC {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
                    return HomePageLayout.shared.makePlacesLayout()
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


