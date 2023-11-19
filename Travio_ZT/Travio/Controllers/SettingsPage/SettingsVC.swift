//
//  SettingsVC.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

class SettingsVC: UIViewController, EditProfileDelegate {
    
    private let settingsVM = SettingsVM()
    
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
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 50
        return profileImage
    }()
    
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(UIColor(named: "background"), for: .normal)
        button.addTarget(self, action: #selector(buttonEditProfileTapped), for: .touchUpInside)
        
        return button
    }()
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "İptal Et", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Çıkış Yap", style: .destructive) { _ in
            AccessManager.shared.deleteToken(accountIdentifier: "access-token")
            let vc = LoginVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func buttonEditProfileTapped() {
        let editProfileVC = EditProfileVC()
        editProfileVC.delegate = self
        present(editProfileVC, animated: true)
    }
    
    @objc override func buttonTapped() {
        showAlert(message: "Çıkış yapmak istediğinize emin misiniz?")
    }
    
    
    private func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.textAlignment = alignment
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    private func updateUI(with profile: ProfileResponse) {
        profileText.text = profile.full_name ?? "Default Name"
        
        if let imageUrl = profile.pp_url, let url = URL(string: imageUrl) {
            let options: KingfisherOptionsInfo = [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
            
            profileImage.kf.setImage(with: url, options: options)
        }
    }
    
    
    private lazy var profileText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 16, fontName: "Poppins-SemiBold", alignment: .center)
    
    private lazy var editProfileText = createLabel(text: "Edit Profile", color: "seeAllColor", textSize: 12, fontName: "Poppins-SemiBold", alignment: .center)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.isNavigationBarHidden = true

        settingsVM.myProfile()
        settingsVM.dataTransfer = { [weak self] profile in
            self?.updateUI(with: profile)
        }
    }
    

    func profileDidUpdate(fullName: String, image: UIImage) {
        profileText.text = fullName
        profileImage.image = image
    }
    
    
    func setupViews() {
        setupView(title: "Settings", buttonImage: UIImage(named: "img_logout"), buttonPosition: .right, headerLabelPosition: .left, buttonAction: #selector(buttonTapped), itemsView: [collectionView, profileImage, profileText,editProfileButton])
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
            make.size.equalTo(120)
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
            case 1: break
                //                let appDefaults = EditProfileVC()
                //                navigationController?.pushViewController(appDefaults, animated: true)
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
