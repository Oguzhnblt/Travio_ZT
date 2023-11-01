//
//  EditProfileVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit


class EditProfileVC: UIViewController {
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = "Edit Profile"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(.imgExit, for: .normal)
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = .image3
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Change Photo", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)

        return button
    }()
    
    private lazy var profileName: UILabel = {
        let label = UILabel()
        label.text = "Bruce Wills"
        label.font = UIFont(name: "Poppins-SemiBold", size: 24)
        label.textAlignment = .center
        
        return label
    }()
        
    private lazy var editProfileItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    

   
    @objc func exitButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   

        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .background
        self.view.addSubviews(editProfileItemView, headerLabel, exitButton)
        editProfileItemView.addSubviews(profileImage, changePhotoButton, profileName, CustomView.view)
        
        
        
        
        setupLayouts()
        
    }
    
    private func setupLayouts() {
               
        headerLabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(24)
        })
        
        exitButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.right.equalToSuperview().offset(-24)

        })
        
        editProfileItemView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(135)
            make.left.right.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview()
            
        })
        
        changePhotoButton.snp.makeConstraints({make in
            make.top.equalTo(profileImage.snp.bottom)
            make.left.right.equalToSuperview()
        })
        
        profileName.snp.makeConstraints({make in
            make.top.equalTo(changePhotoButton.snp.bottom)
            make.left.right.equalToSuperview()
        })
        
        CustomView.view.configure(text: "1 Kasım 2023", image: .imgSign)
        CustomView.view.snp.makeConstraints({make in
            make.top.equalTo(profileName.snp.bottom)
            make.left.right.equalToSuperview()
        })
        
        
    }
}



#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct EditProfileVC_Preview: PreviewProvider {
    static var previews: some View{
        
        EditProfileVC().showPreview()
    }
}
#endif
