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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .always
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
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
        label.textColor = UIColor(named: "backgroundColor")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var privacyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = headerLabel[1]
        label.textColor = UIColor(named: "backgroundColor")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var privacyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [camera, photoLibrary, location])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var changePasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newPasswordField, newPasswordConfirmField])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        saveButton.backgroundColor = UIColor(named: "backgroundColor")
        return saveButton
    }()
    
    @objc private func saveButtonTapped() {
        let validation = viewModel.validatePasswordFields(newPassword: newPasswordField.textField.text, confirmPassword: newPasswordConfirmField.textField.text)
        
        switch validation {
        case .success:
            guard let new_password = newPasswordField.textField.text else { return }
            viewModel.changePassword(ChangePasswordRequest(new_password: new_password))
            viewModel.successAlert = { message in
                Alerts.showAlert(from: self, title: "Uyarı", message: message, actionTitle: "Tamam")
            }
        case .failure(let errorMessage):
                Alerts.showAlert(from: self, title: "Uyarı", message: errorMessage, actionTitle: "Tamam")
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
                    Alerts.showAlert(from: self, title: "Permission Required", message: "Please go to settings and enable \(privacyType.rawValue) permissions.", actionTitle: "Settings", cancelTitle: "Cancel") {
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
        
        setupView(title: "Security Settings", buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [scrollView])
        
        scrollView.addSubviews(containerView)
        containerView.addSubviews(passwordHeaderLabel, privacyHeaderLabel, changePasswordStackView, privacyStackView, saveButton)
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        containerView.snp.makeConstraints({ make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        })
        
        changePasswordStackView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(55)
            make.left.right.equalToSuperview().inset(8)
        })
        
        privacyStackView.snp.makeConstraints({ make in
            make.top.equalTo(changePasswordStackView.snp.bottom).offset(55)
            make.left.right.equalToSuperview().inset(8)
        })
        
        passwordHeaderLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(changePasswordStackView.snp.top)
            make.left.equalToSuperview().offset(16)
        })
        
        privacyHeaderLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(privacyStackView.snp.top)
            make.left.equalToSuperview().offset(16)
        })
        
        saveButton.snp.makeConstraints({ make in
            make.top.equalTo(privacyStackView.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-60)
        })
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

