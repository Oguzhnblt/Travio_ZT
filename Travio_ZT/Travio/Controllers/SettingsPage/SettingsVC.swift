//
//  SettingsVC.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    let cellDataArray: [SettingsCellData] = [
        SettingsCellData(iconName: "user_alt", labelText: "Security Settings"),
        SettingsCellData(iconName: "app_defaults", labelText: "App Defaults"),
        SettingsCellData(iconName: "map_pin_icon", labelText: "My Added Places"),
        SettingsCellData(iconName: "help_icon", labelText: "Help & Supports"),
        SettingsCellData(iconName: "about_info_icon", labelText: "About"),
        SettingsCellData(iconName: "terms_icon", labelText: "Terms of Use"),
    ]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: settingsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
   
    
    private lazy var profileImage : UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "img_profile")
        return profileImage
    }()
    
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(UIColor(named: "background"), for: .normal)
        button.addTarget(self, action: #selector(buttonEditProfileTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonEditProfileTapped() {
        let editProfileVC = EditProfileVC()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc func buttonLogoutTapped(){
        print("Tıklandı")
    }
    
    private func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.textAlignment = alignment
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    
   
    private lazy var profileText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 16, fontName: "Poppins-SemiBold", alignment: .center)
    
    private lazy var editProfileText = createLabel(text: "Edit Profile", color: "seeAllColor", textSize: 12, fontName: "Poppins-SemiBold", alignment: .center)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    
    func setupViews() {
        setupView(title: "Settings", buttonImage: UIImage.imgLogout, buttonPosition: .right, headerLabelPosition: .left, buttonAction: nil, itemsView: [collectionView, profileImage, profileText, editProfileButton])
        setupLayout()
    }
    
    func setupLayout() {
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.equalTo(editProfileButton.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        })
        
        profileImage.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        })
        
        profileText.snp.makeConstraints({make in
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        })
        
        editProfileButton.snp.makeConstraints({make in
            make.top.equalTo(profileText.snp.bottom)
            make.centerX.equalToSuperview()
        })
        
    
    }
}

extension SettingsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.identifier, for: indexPath) as! SettingsCollectionViewCell
        
        let data = cellDataArray[indexPath.item]
        cell.configure(with: data)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
            case 0:
                let securitySettings = SecuritySettingsVC()
                navigationController?.pushViewController(securitySettings, animated: true)
            case 1:
                let appDefaults = EditProfileVC()
                navigationController?.pushViewController(appDefaults, animated: true)
            case 2:
                let myAdded = MyAddedPlacesVC()
                navigationController?.pushViewController(myAdded, animated: true)
            case 3:
                let helpSupport = HelpSupportTableVC()
                navigationController?.pushViewController(helpSupport, animated: true)
            case 4:
                let about = AboutUsVC()
                navigationController?.pushViewController(about, animated: true)
            default: 
                let termsOfUse = TermsOfUseVC()
                navigationController?.pushViewController(termsOfUse, animated: true)
                
        }
    }
}

extension SettingsVC: UICollectionViewDelegate {
    
}

extension SettingsVC {
    
    func settingsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.settingLayouts()
        }
    }
    
    
    func settingLayouts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.15))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.interGroupSpacing = 8
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 20, trailing: 16)
        
        return layoutSection
    }
    
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SettingsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        SettingsVC().showPreview().ignoresSafeArea()
    }
}
#endif
