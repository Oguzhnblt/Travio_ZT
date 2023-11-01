//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import SnapKit

class SecuritySettingsVC: UIViewController {
    
    
    let popularPlacesId = "PopularPlacesHeader"
    let newPlacesId = "NewPlacesHeader"
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: securitySettingsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(PlacesCollectionViewCell.self, forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = "Security Settings"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.leftArrowIcon, for: .normal)
        return button
    }()
    
    private lazy var loginItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
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
        self.view.backgroundColor = .background
        self.view.addSubviews(loginItemView,backButton, headerLabel)
        loginItemView.addSubviews(collectionView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        backButton.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(24)
        })
        
        headerLabel.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        })
        
        loginItemView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(125)
            make.left.right.equalToSuperview()
        }
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().offset(16)
        })
    }
}

// MARK: -- COLLECTION VİEW

extension SecuritySettingsVC: UICollectionViewDelegateFlowLayout {
    
    // Her bir item'in boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension SecuritySettingsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // Section sayısı
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return popularPlacesMockData.count
            default:
                return newPlacesMockData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as! PlacesCollectionViewCell
                cell.cellData = popularPlacesMockData[indexPath.row]
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCollectionViewCell.identifier, for: indexPath) as! PlacesCollectionViewCell
                cell.cellData = newPlacesMockData[indexPath.row]
                return cell
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            
            let sectionTitles = ["Popular Places", "New Places"]
            
            if indexPath.section < sectionTitles.count {
                header.title.text = sectionTitles[indexPath.section]
                
                switch indexPath.section {
                    case 0:
                        header.button.setTitle("See All", for: .normal)
                        header.button.addTarget(self, action: #selector(seeAllPopular), for: .touchUpInside)
                    case 1:
                        header.button.setTitle("See All", for: .normal)
                        header.button.addTarget(self, action: #selector(seeAllNew), for: .touchUpInside)
                    default:
                        header.button.setTitle("See All", for: .normal)
                        header.button.addTarget(self, action: #selector(seeAllDefault), for: .touchUpInside)
                }
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
        //let seeAllVC = PopularPlacesVC()
        //navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    @objc func seeAllNew() {
        print( "Handle the action for See All New")
        
    }
    
    @objc func seeAllDefault() {
        print( "Handle the action for See All Default")
        
    }
}

extension SecuritySettingsVC {
    
    func securitySettingsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (_, env) -> NSCollectionLayoutSection? in
            return SecuritySettingsLayout.shared.securitySettingsLayout()
        }
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SecuritySettingsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        SecuritySettingsVC().showPreview()
    }
}
#endif

