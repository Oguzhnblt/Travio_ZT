//
//  HelpSupportVC.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.
//

import Foundation
import UIKit
import SnapKit

class HelpSupportVC: UIViewController {
    
    let cellDataArray: [HelpSupportData] = [
        HelpSupportData(iconName: "user_alt", labelText: "How can I create a new account on Travio?"),
        HelpSupportData(iconName: "app_defaults", labelText: "App Defaults"),
        HelpSupportData(iconName: "map_pin_icon", labelText: "My Added Places"),
        HelpSupportData(iconName: "help_icon", labelText: "Help & Supports"),
        HelpSupportData(iconName: "about_info_icon", labelText: "About"),
        HelpSupportData(iconName: "terms_icon", labelText: "Terms of Use"),
    ]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: settingsLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(HelpSupportCell.self, forCellWithReuseIdentifier: HelpSupportCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    
    private lazy var helpSupportItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
 
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "img_logout"), for: .normal)
        button.addTarget(self, action: #selector(buttonLogoutTapped), for: .touchUpInside)
        
        return button
    }()
   
    
    
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
    
    private lazy var labelText = createLabel(text: "Help&Support", color: "textFieldBackgroundColor", textSize: 32, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var faqText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 16, fontName: "Poppins-SemiBold", alignment: .center)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    
    func setupViews() {
        self.view.addSubviews(helpSupportItemView,logoutButton,labelText)
        self.view.backgroundColor = .background
        helpSupportItemView.addSubviews(faqText,collectionView)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        helpSupportItemView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview().offset(125)
            make.left.right.equalToSuperview()
            
        })
        
        labelText.snp.makeConstraints({make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(75)
        })
        
        faqText.snp.makeConstraints({make in
            make.bottom.equalTo(collectionView.snp.top).offset(30)
        })
        
        logoutButton.layer.zPosition = 10
        logoutButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(75)
        })
       
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview().offset(0)
            make.left.right.equalToSuperview().inset(16)
        })
    }
}


extension HelpSupportVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpSupportCell.identifier, for: indexPath) as! HelpSupportCell
        
        let data = cellDataArray[indexPath.item]
        cell.configure(with: data)
        return cell
    }
}


extension HelpSupportVC: UICollectionViewDelegate {
    
}

extension HelpSupportVC {
    
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
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 0, bottom: 200, trailing: 0)
        
        return layoutSection
    }
    
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HelpSupportVC_Preview: PreviewProvider {
    static var previews: some View{
        
        HelpSupportVC().showPreview()
    }
}
#endif


