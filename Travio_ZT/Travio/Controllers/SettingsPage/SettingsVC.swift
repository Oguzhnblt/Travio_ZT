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
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    
    private lazy var profileImage : UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "img_profile")
        profileImage.frame.size = CGSize(width: 120, height: 120)
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 60
        return profileImage
    }()
    
    private lazy var editProfileButton = createButton(title: "Edit Profile", action: #selector(buttonEditProfileTapped), titleColor: .background, backgroundColor: nil, font: .regular, size: .size12)
    

    @objc func buttonEditProfileTapped() {
        let editProfileVC = EditProfileVC()
        editProfileVC.delegate = self
        present(editProfileVC, animated: true)
    }
    
    @objc override func buttonTapped() {
        showAlert(title: "Uyarı", message: "Çıkış yapmak istediğinize emin misiniz?", actionTitle: "Çıkış yap", cancelTitle: "İptal Et") {
            AccessManager.shared.deleteToken(accountIdentifier: "access-token")
            let loginVC = LoginVC()
            loginVC.previousViewController = nil
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    private func updateUI(with profile: ProfileResponse) {
        profileText.text = profile.full_name ?? "Default Name"
        
        if let imageUrl = profile.pp_url, let url = URL(string: imageUrl) {
            profileImage.kf.setImage(with: url)
        }
    }
    
    
    private lazy var profileText = createLabel(text: "Bruce Wills", textSize: .size16, fontType: .semibold, alignment: .center)
  
    
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
            make.size.equalTo(profileImage.frame.size)
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
}

extension SettingsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
                
            case 0:
                let securitySettings = SecuritySettingsVC()
                navigationController?.pushViewController(securitySettings, animated: true)
            case 1: break
       
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
