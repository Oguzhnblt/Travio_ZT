//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit
import AVFoundation
import CoreLocation
import Photos

class SecuritySettingsVC: UIViewController {
    
    private lazy var viewModel = SecuritySettingsVM()
    private lazy var privacyManager = PrivacyManager.shared
    
    private lazy var contentViewSize: CGSize = {
        let width = self.view.frame.width
        let height = self.view.frame.height
        return CGSize(width: width, height: height)
    }()
    
    private lazy var scrollSize: CGSize = {
        let width = self.view.frame.width
        let height = 670.0
        return CGSize(width: width, height: height)

    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = scrollSize
        scrollView.frame = view.bounds
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.frame.size = contentViewSize
        return containerView
    }()
    
    private let headerLabel = ["Change Password", "Privacy"]
    private let passwordItems = ["New Password", "New Password Confirm"]
    private let privacyItems = ["Camera", "Photo Library", "Location"]
    
    private lazy var newPasswordField = CommonTextField(labelText: passwordItems[0], textFieldPlaceholder: "******", isSecure: true)
    private lazy var newPasswordConfirmField = CommonTextField(labelText: passwordItems[1], textFieldPlaceholder: "******", isSecure: true)
    
    private lazy var camera: PrivacyField = {
        let field = PrivacyField(labelText: privacyItems[0], isOn: false)
        field.toggleSwitch.tag = 0
        field.toggleSwitch.addTarget(self, action: #selector(privacySwitchValueChanged), for: .valueChanged)
        return field
    }()
    
    private lazy var photoLibrary: PrivacyField = {
        let field = PrivacyField(labelText: privacyItems[1], isOn: false)
        field.toggleSwitch.tag = 1
        field.toggleSwitch.addTarget(self, action: #selector(privacySwitchValueChanged), for: .valueChanged)
        return field
    }()
    
    private lazy var location: PrivacyField = {
        let field = PrivacyField(labelText: privacyItems[2], isOn: false)
        field.toggleSwitch.tag = 2
        field.toggleSwitch.addTarget(self, action: #selector(privacySwitchValueChanged), for: .valueChanged)
        return field
    }()
    
    private lazy var passwordHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = headerLabel[0]
        label.textColor = AppTheme.getColor(name: .background)
        label.font = AppTheme.getFont(name: .semibold, size: .size16)
        return label
    }()
    
    private lazy var privacyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = headerLabel[1]
        label.textColor = AppTheme.getColor(name: .background)
        label.font = AppTheme.getFont(name: .semibold, size: .size16)
        return label
    }()
    
    private lazy var privacyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [camera, photoLibrary, location])
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var changePasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newPasswordField, newPasswordConfirmField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var saveButton = createButton(title: "Save", action: #selector(saveButtonTapped))
    
    @objc private func saveButtonTapped() {
        let validation = viewModel.validatePasswordFields(newPassword: newPasswordField.textField.text, confirmPassword: newPasswordConfirmField.textField.text)
        
        switch validation {
            case .success:
                guard let new_password = newPasswordField.textField.text else { return }
                viewModel.changePassword(ChangePasswordRequest(new_password: new_password))
                viewModel.successAlert = { message in
                    self.showAlert(title: "Uyarı", message: message, actionTitle: "Tamam")
                }
            case .failure(let errorMessage):
                showAlert(title: "Uyarı", message: errorMessage, actionTitle: "Tamam")
        }
    }
    
    @objc private func privacySwitchValueChanged(sender: UISwitch) {
        guard let privacyType = privacyManager.switchTagToPrivacyType(sender.tag) else { return }
        
        if sender.isOn {
            privacyManager.requestPermission(for: privacyType) { granted in
                if granted {
                    sender.isOn = true
                } else {
                    sender.isOn = false
                    self.showAlert(title: "Permission Required", message: "Please go to settings and enable \(privacyType.rawValue) permissions.", actionTitle: "Settings", cancelTitle: "Cancel") {
                        self.privacyManager.openAppSettings()
                        
                    }
                }
            }
        } else {
            privacyManager.updatePermission(for: privacyType, isEnabled: false)
            privacyManager.openAppSettings()
        }
    }
    
    private func observePermissionChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(permissionStatusChanged(_:)), name: PrivacyManager.permissionStatusChangedNotification, object: nil)
    }
    
    @objc private func permissionStatusChanged(_ notification: Notification) {
        
    }
    
    private func updatePrivacySwitches() {
        camera.toggleSwitch.isOn = privacyManager.isPermissionGranted(for: .camera)
        photoLibrary.toggleSwitch.isOn = privacyManager.isPermissionGranted(for: .photoLibrary)
        location.toggleSwitch.isOn = privacyManager.isPermissionGranted(for: .location)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        updatePrivacySwitches()
        observePermissionChanges()
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
        setupView(
            title: "Security Settings",
            buttonImage: UIImage(named: "leftArrowIcon"),
            buttonPosition: .left,
            headerLabelPosition: .center,
            buttonAction: #selector(buttonTapped),
            itemsView: [scrollView]
        )
        
        scrollView.addSubviews(containerView)
        containerView.addSubviews(passwordHeaderLabel, privacyHeaderLabel, changePasswordStackView, privacyStackView, saveButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        passwordHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(changePasswordStackView.snp.top).offset(-10)
        }
        
        changePasswordStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordHeaderLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(privacyHeaderLabel.snp.top).offset(-20)

        }
        
        privacyHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(changePasswordStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(privacyStackView.snp.top).offset(-10)

        }
        
        
        privacyStackView.snp.makeConstraints { make in
            make.top.equalTo(privacyHeaderLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(8)

        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(privacyStackView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }
}



#if DEBUG
import SwiftUI
import AVFoundation

@available(iOS 13, *)
struct SecuritySettingsVC_Preview: PreviewProvider {
    static var previews: some View {
        SecuritySettingsVC().showPreview().ignoresSafeArea()
    }
}
#endif

