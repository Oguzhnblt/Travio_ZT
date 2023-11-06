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
        button.setImage(UIImage(named: "img_exit"), for: .normal)
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img_profile")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Change Photo", for: .normal)
        button.setTitleColor(UIColor(named: "background"), for: .normal)
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
    
    private lazy var adminCell: EditingProfileCell = {
        let cell = EditingProfileCell()
        cell.label.text = "Admin"
        cell.signImage.image = UIImage(named: "imgAdmin")
        
        return cell
    }()
    
    private lazy var signCell: EditingProfileCell = {
        let cell = EditingProfileCell()
        cell.label.text = "2 Kasım 2023"
        cell.signImage.image = UIImage(named: "imgSign")
        return cell
    }()
    
    private lazy var cellStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var fullNameField: TextFieldCell = {
        let field = TextFieldCell()
        field.fieldLabel.text = "Full Name"
        field.textField.placeholder = "bilge_adam"
        
        return field
    }()
    
    private lazy var emailField: TextFieldCell = {
        let field = TextFieldCell()
        field.fieldLabel.text = "Email"
        field.textField.placeholder = "deneme@example.com"
        
        return field
    }()
    
    private lazy var fieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var saveButton: UIButton = {
    
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = UIColor(named: "background")
        return saveButton
    }()
    
    
    
    @objc func saveButtonTapped() {
        
    }
 
    @objc func exitButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
  
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor(named: "background")
   
      
        self.view.addSubviews(editProfileItemView, headerLabel, exitButton)
        
        cellStackView.addArrangedSubviews(signCell,adminCell)
        
        editProfileItemView.addSubviews(profileImage, changePhotoButton, profileName,cellStackView,fullNameField,emailField,saveButton)
        
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
        
        cellStackView.dropShadow()
        cellStackView.snp.makeConstraints({make in
            make.top.equalTo(profileName.snp.bottom).offset(21)
            make.left.right.equalToSuperview().inset(24)
        })
        
        fullNameField.dropShadow()
        fullNameField.snp.makeConstraints({make in
            make.top.equalTo(cellStackView.snp.bottom).offset(21)
            make.left.right.equalToSuperview().inset(24)
        })
        
        emailField.dropShadow()
        emailField.snp.makeConstraints({make in
            make.top.equalTo(fullNameField.snp.bottom).offset(21)
            make.left.right.equalToSuperview().inset(24)
        })
        
        saveButton.snp.makeConstraints({make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.left.right.equalToSuperview().inset(24)
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
