//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import Foundation
import SnapKit

class SecuritySettingsVC: UIViewController {
    

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
    
    private lazy var newPassword = ChangePasswordCell.field.configure(text:"New Password", fieldText: "")
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .background
        self.view.addSubviews(securityItemView,backButton, headerLabel)
        securityItemView.addSubviews(saveButton)
        
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



#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SecuritySettingsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        SecuritySettingsVC().showPreview()
    }
}
#endif

