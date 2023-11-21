//
//  EditProfileVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol EditProfileDelegate: AnyObject {
    func profileDidUpdate(fullName: String, image: UIImage)
}

enum IndicatorState {
    case start
    case stop
}


class EditProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    weak var delegate: EditProfileDelegate?
    
    private lazy var viewModel = EditProfileVM()
    private var imageDatas: [UIImage] = []
    private func showIndicator(state: IndicatorState) {
        switch state {
        case .start:
            profileImage.subviews.compactMap { $0 as? UIActivityIndicatorView }.first?.startAnimating()
        case .stop:
            profileImage.subviews.compactMap { $0 as? UIActivityIndicatorView }.first?.stopAnimating()
        }
    }
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img_profile")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 50
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        image.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
        
        return image
    }()
    
    
    private func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
   
    private lazy var changePhotoButton = ButtonUtility.createButton(from: self, title: "Change Photo", action: #selector(changePhotoTapped), titleColor: UIColor(named: "backgroundColor"), backgroundColor: nil)
    
    private lazy var saveButton: UIButton = {
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = UIColor(named: "backgroundColor")
        return saveButton
    }()
    
    
    private lazy var profileName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    
    private func editingProfileCell(labelText: String, imageName: String) -> EditingProfileCell {
        let cell = EditingProfileCell()
        cell.label.text = labelText
        cell.signImage.image = UIImage(named: imageName)
        return cell
    }
    private func stackView(axis: NSLayoutConstraint.Axis, views: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = axis
        stack.spacing = 8
        return stack
    }
   
    private lazy var adminCell = editingProfileCell(labelText: "Admin", imageName: "img_admin")
    private lazy var signCell = editingProfileCell(labelText: "2 Kasım 2023", imageName: "img_sign")
    
    
    private lazy var fullNameField = CommonTextField(labelText: "Full Name", textFieldPlaceholder: "bilge_adam", isSecure: false)
    private lazy var emailField = CommonTextField(labelText: "Email", textFieldPlaceholder: "deneme@example.com", isSecure: false)
    
    
    private lazy var cellStackView = stackView(axis: .horizontal, views: [signCell, adminCell])
    private lazy var fieldStackView = stackView(axis: .vertical, views: [fullNameField, emailField])
    private lazy var stackViews = stackView(axis: .vertical, views: [cellStackView, fieldStackView])
    
    
    func profileUpdated(with profileInfo: ProfileResponse) {
        showIndicator(state: .start)
        guard let fullName = profileInfo.full_name,
              let ppUrlString = profileInfo.pp_url,
              let imageUrl = URL(string: ppUrlString),
              let createdAt = profileInfo.created_at,
              let formattedDate = DateFormatter.formattedDate(
                from: createdAt,
                originalFormat: FormatType.longFormat.rawValue,
                targetFormat: FormatType.stringFormat.rawValue,
                localeIdentifier: "tr_TR")
        else {return}
        
        profileName.text = fullName
        profileImage.kf.setImage(with: imageUrl) {_ in
            self.showIndicator(state: .stop)
        }
    
        adminCell.label.text = profileInfo.role ?? "User"
        signCell.label.text = formattedDate
        emailField.textField.text = profileInfo.email ?? ""
        fullNameField.textField.text = fullName
        
        
    }
    
    
    @objc func saveButtonTapped() {
        showIndicator(state: .start)

        guard let fullName = fullNameField.textField.text,
              let email = emailField.textField.text else {
            Alerts.showAlert(from: self, title: "Uyarı", message: "Lütfen geçerli bir ad ve e-posta girin.", actionTitle: "Tamam")
                    showIndicator(state: .stop)
            return }
        let validationResult = viewModel.validateInputs(fullName: fullName, email: email)

            if !validationResult.isValid {
                Alerts.showAlert(from: self, title: "Uyarı", message: validationResult.errorMessage, actionTitle: "Tamam")
                showIndicator(state: .stop)
                return
            }
        viewModel.uploadImage(images: imageDatas)
        viewModel.transferURLs = { [weak self] url in
            let pp_url = url.first
            self?.viewModel.changeMyProfile(profile: EditProfileRequest(full_name: fullName, email: email, pp_url: pp_url!))
        }
        
        profileName.text = fullName
        
        viewModel.showAlertVM = { message in
            Alerts.showAlert(from: self, title: "Uyarı", message: message, actionTitle: "Tamam")
            self.showIndicator(state: .stop)
            
            if let fullName = self.fullNameField.textField.text {
            self.delegate?.profileDidUpdate(fullName: fullName, image: self.profileImage.image ?? UIImage())
        }

        }
    }
    
    @objc func changePhotoTapped() {
        imagePicker()
    }
    
    
    
    @objc func exitButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
        
        viewModel.myProfile()
        viewModel.dataTransfer = { [weak self] profile in
            self?.profileUpdated(with: profile)
            
        }
        
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        
        setupView(title: "Edit Profile", buttonImage: UIImage(named: "img_exit"), buttonPosition: .right, headerLabelPosition: .left, headerLabelTopOffset: 20, buttonAction: #selector(buttonTapped), itemsView: [profileImage, changePhotoButton, profileName, stackViews, saveButton])
        
        setupLayouts()
    }
    
    @objc override func buttonTapped() {
        self.dismiss(animated: true)
    }
    
    private func setupLayouts() {
        
        profileImage.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.size.equalTo(120)
        })
        
        changePhotoButton.snp.makeConstraints({make in
            make.top.equalTo(profileImage.snp.bottom)
            make.left.right.equalToSuperview()
        })
        
        profileName.snp.makeConstraints({make in
            make.top.equalTo(changePhotoButton.snp.bottom)
            make.left.right.equalToSuperview()
        })
        
        stackViews.dropShadow()
        stackViews.snp.makeConstraints({make in
            make.top.equalTo(profileName.snp.bottom).offset(21)
            make.left.right.equalToSuperview().inset(24)
        })
        
        saveButton.snp.makeConstraints({make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.left.right.equalToSuperview().inset(24)
            make.width.equalTo(342)
            make.height.equalTo(51)
            
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
            imageDatas.append(selectedImage)
            
            
            dismiss(animated: true, completion: nil)
        }
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
