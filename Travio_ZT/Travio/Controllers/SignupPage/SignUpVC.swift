//
//  SignUpVC.swift
//  Travio
//
//  Created by Oğuz on 15.10.2023.
//


import Foundation
import UIKit
import SnapKit

class SignUpVC: UIViewController {
    
    private lazy var viewModel = SignUpVM()
    
    private lazy var fullNameField = CommonTextField(labelText: "Username", textFieldPlaceholder: "bilge_adam", isSecure: false)
    private lazy var emailField = CommonTextField(labelText: "Email", textFieldPlaceholder: "deneme@example.com", isSecure: false)
    private lazy var passwordField = CommonTextField(labelText: "Password", textFieldPlaceholder: "", isSecure: true)
    private lazy var passwordConfirmField = CommonTextField(labelText: "Password Confirm", textFieldPlaceholder: "", isSecure: true)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fullNameField, emailField, passwordField, passwordConfirmField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 24
        return stackView
    }()
    
   
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.backgroundColor = UIColor(named: "signUpColor")?.cgColor
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func signUpButtonTapped() {
        
        guard let fullName = fullNameField.textField.text,
              let email = emailField.textField.text,
              let password = passwordField.textField.text,
              let confirmPassword = passwordConfirmField.textField.text
        else { return }

        viewModel.signUp(fullName: fullName, email: email, password: password, confirmPassword: confirmPassword)

        viewModel.showAlertFailure = { message in
            self.showAlert(message: message)
        }

    }

    
    // MARK: ShowAlert
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func navigateToLoginViewController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    
    private func setupViews() {
        setupView(title: "Sign Up", buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center ,buttonAction: #selector(buttonTapped), itemsView: [stackView, signUpButton])
        
        stackView.dropShadow()
        stackView.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(72)
            make.left.right.equalToSuperview().inset(16)
        })
        
        signUpButton.snp.makeConstraints({make in
            make.bottom.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(342)
            make.height.equalTo(54)
        })
        
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SignUpVC_Preview: PreviewProvider {
    static var previews: some View{
        
        SignUpVC().showPreview()
    }
}
#endif
