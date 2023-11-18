//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class SecuritySettingsVC: UIViewController {
    private lazy var viewModel = SecuritySettingsVM()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * 2, height: view.frame.height * 2)
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
    
    
    private let headerLabel = ["Change Password","Privacy"]
    private let passwordItems = ["New Password", "New Password Confirm"]
    private let privacyItems = ["Camera", "Photo Library","Location"]
    
    private lazy var newPasswordField = CommonTextField(labelText: passwordItems[0], textFieldPlaceholder: "******", isSecure: true)
    private lazy var newPasswordConfirmField = CommonTextField(labelText: passwordItems[1], textFieldPlaceholder: "******", isSecure: true)
    
    
    private lazy var camera = PrivacyField(labelText: privacyItems[0], isOn: false)
    private lazy var photoLibrary = PrivacyField(labelText: privacyItems[1], isOn: false)
    private lazy var location = PrivacyField(labelText: privacyItems[2], isOn: false)
    
    private lazy var passwordHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = headerLabel[0]
        label.textColor = UIColor(named: "backgroundColor")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var privacyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = headerLabel[1]
        label.textColor = UIColor(named: "backgroundColor")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    private lazy var privacyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [camera, photoLibrary, location])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var changePasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newPasswordField, newPasswordConfirmField])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var itemStackViews: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [changePasswordStackView, privacyStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 48
        return stackView
    }()
    
    
    
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        saveButton.backgroundColor = UIColor(named: "backgroundColor")
        return saveButton
    }()
    
    
    @objc func saveButtonTapped() {
        let validation = viewModel.validatePasswordFields(newPassword: newPasswordField.textField.text, confirmPassword: newPasswordConfirmField.textField.text)
        
        switch validation {
            case .success:
                guard let new_password = newPasswordField.textField.text else {
                    return
                }
                viewModel.changePassword(profile: ChangePasswordRequest(new_password: new_password)) { result in
                    switch result {
                        case .success(let successMessage):
                            self.showAlert(message: successMessage)
                            
                        case .failure(let error):
                            self.showAlert(message: error.localizedDescription)
                    }
                }
            case .failure(let errorMessage):
                showAlert(message: errorMessage)
        }
    }
    
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        
        setupView(title: "Security Settings", buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [scrollView])
        
        scrollView.addSubviews(containerView)
        containerView.addSubviews(passwordHeaderLabel,privacyHeaderLabel,changePasswordStackView,privacyStackView, saveButton)
        
        
        scrollView.snp.makeConstraints({make in
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
            make.bottom.equalToSuperview().offset(-55)
            make.left.right.equalToSuperview().inset(16)
            make.width.equalTo(342)
            make.height.equalTo(54)
        })
    }
}



#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SecuritySettingsVC_Preview: PreviewProvider {
    static var previews: some View {
        SecuritySettingsVC().showPreview().ignoresSafeArea()
    }
}
#endif

