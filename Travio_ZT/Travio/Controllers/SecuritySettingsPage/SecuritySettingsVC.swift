//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import SnapKit

class SecuritySettingsVC: UIViewController {
    
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: securitySettingsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(SecuritySettingsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SecuritySettingsHeaderView.reuseIdentifier)
        
        collectionView.register(ChangePasswordCell.self, forCellWithReuseIdentifier: ChangePasswordCell.identifier)
        
        collectionView.register(PrivacyCell.self, forCellWithReuseIdentifier: PrivacyCell.identifier)
        
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
    
    private lazy var saveButton: UIButton = {
    
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.size(CGSize(width: 342, height: 54))
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = .background
        return saveButton
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
    
    @objc func saveButtonTapped() {
     print("tık")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .background
        self.view.addSubviews(securityItemView,backButton, headerLabel)
        securityItemView.addSubviews(collectionView, saveButton)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        securityItemView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(125)
            make.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
            make.left.equalToSuperview().offset(24)
        })
        
        headerLabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        })
        
       
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        })
        
        saveButton.snp.makeConstraints({ make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(securityItemView.snp.top).offset(647)
            make.left.right.equalToSuperview().inset(24)
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
                return 2
            default:
                return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChangePasswordCell.identifier, for: indexPath) as! ChangePasswordCell
                
                let label = ["New Password", "New Password Confirm"]
                
                if indexPath.item < label.count {
                    cell.label.text = label[indexPath.item]
                }
                
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrivacyCell.identifier, for: indexPath) as! PrivacyCell
                
                let label = ["Camera", "Photo Library", "Location"]
                
                if indexPath.item < label.count {
                    cell.label.text = label[indexPath.item]
                }
                
                return cell
            default: 
                break
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SecuritySettingsHeaderView.reuseIdentifier, for: indexPath) as! SecuritySettingsHeaderView
            
            let label = ["Change Password", "Privacy"]
            
            if indexPath.section < label.count {
                header.title.text = label[indexPath.section]
            }
    
            return header
        }
        return UICollectionReusableView()
    }
}

extension SecuritySettingsVC {
    
    func securitySettingsLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (_, env) -> NSCollectionLayoutSection? in
            return SecuritySettingsLayout.shared.securitySettingsPage()
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

