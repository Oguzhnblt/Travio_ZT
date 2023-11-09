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
    
    
    private lazy var settingsItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private lazy var profileImage : UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "img_profile")
        return profileImage
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "img_logout"), for: .normal)
        button.addTarget(self, action: #selector(buttonLogoutTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(UIColor(named: "background"), for: .normal)
        button.addTarget(self, action: #selector(buttonEditProfileTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonEditProfileTapped() {
        
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var settingsText = createLabel(text: "Settings", color: "textFieldBackgroundColor", textSize: 32, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var profileText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 16, fontName: "Poppins-SemiBold", alignment: .center)
    
    private lazy var editProfileText = createLabel(text: "Edit Profile", color: "backgroundColor", textSize: 12, fontName: "Poppins-SemiBold", alignment: .center)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    
    func setupViews() {
        self.view.addSubviews(settingsItemView,logoutButton,settingsText)
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        settingsItemView.addSubviews(profileImage, profileText, editProfileButton,collectionView)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        settingsItemView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview().offset(135)
            make.left.right.equalToSuperview()
            
        })
        
        settingsText.snp.makeConstraints({make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(85)
        })
        
        logoutButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
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
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().offset(218)
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
                let editProfile = EditProfileVC()
                navigationController?.pushViewController(editProfile, animated: true)
            case 2:
                let myAdded = MyAddedPlacesVC()
                navigationController?.pushViewController(myAdded, animated: true)
            case 3:
                let helpSupport = HelpSupportVC()
                navigationController?.pushViewController(helpSupport, animated: true)
            case 4:
                let placeDetail = PlaceDetailsVC()
                navigationController?.pushViewController(placeDetail, animated: true)
            default: break
                //                let termsOfUse = TermsOfUse()
                //                navigationController?.pushViewController(termsOfUse, animated: true)
                
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
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 200, trailing: 16)
        
        return layoutSection
    }
    
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SettingsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        SettingsVC().showPreview()
    }
}
#endif
