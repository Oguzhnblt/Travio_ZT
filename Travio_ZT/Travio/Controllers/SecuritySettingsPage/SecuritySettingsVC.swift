//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import SnapKit

class SecuritySettingsVC: UIViewController {
    
    let changePassword = "changePassword"
    let privacy = "privacy"

    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: securitySettingsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(SecuritySettingsHeaderView.self, forSupplementaryViewOfKind: changePassword, withReuseIdentifier: SecuritySettingsCollectionCell.identifier)
        
        collectionView.register(SecuritySettingsHeaderView.self, forSupplementaryViewOfKind: privacy, withReuseIdentifier: SecuritySettingsCollectionCell.identifier)

        collectionView.register(SecuritySettingsCollectionCell.self, forCellWithReuseIdentifier: SecuritySettingsCollectionCell.identifier)
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
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var securityItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .background
        self.view.addSubviews(securityItemView,backButton, headerLabel)
        securityItemView.addSubviews(collectionView)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
            make.left.equalToSuperview().offset(24)
        })
        
        headerLabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        })
        
        securityItemView.snp.makeConstraints { make in
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecuritySettingsCollectionCell.identifier, for: indexPath) as! SecuritySettingsCollectionCell
                
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecuritySettingsCollectionCell.identifier, for: indexPath) as! SecuritySettingsCollectionCell
                
                return cell
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SecuritySettingsHeaderView.reuseIdentifier, for: indexPath) as! SecuritySettingsHeaderView
            
            let sectionTitles = ["Popular Places", "New Places"]
            header.title.text = sectionTitles[indexPath.section]
            
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
            return SecuritySettingsLayout.shared.changePasswordLayout()
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

