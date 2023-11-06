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
    private lazy var viewModel = SignUpViewModel()
    
    private func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = .fillProportionally
        stackView.spacing = spacing
        stackView.alignment = .center
        return stackView
    }
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    
    private lazy var loginItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.numberOfLines = 1
        label.textAlignment = alignment
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    
    
    private func addTextField(title: String, placeholder: String, keyboardType: UIKeyboardType, isSecure: Bool) -> CustomLabelTextField {
        let textField = CustomLabelTextField()
        textField.font = UIFont(name: "Poppins-Regular", size: 12)
        textField.backgroundColor = UIColor(named: "textFieldBackgroundColor")
        textField.layer.cornerRadius = 16
        textField.placeholder = placeholder
        textField.customLabel.text = title
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = .none
        return textField
    }
    
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.backgroundColor = UIColor(named: "signUpColor")?.cgColor
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        button.isEnabled = true // Tüm alanlar dolmadan butonun aktif olmaması için
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let buttonImage = UIImage(named: "leftArrowIcon")
        let imageButton = UIButton(type: .system)
        imageButton.setImage(buttonImage, for: .normal)
        imageButton.tintColor = .white
        
        let customBackButtonItem = UIBarButtonItem(customView: imageButton)
        navigationItem.leftBarButtonItem = customBackButtonItem
        
        imageButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return imageButton
    }()
    
    private lazy var passwordMatchWarningLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "backgroundColor")
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    
    @objc private func backButtonTapped() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func signUpButtonTapped() {
        guard let name = usernameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = passwordConfirmTextField.text, !confirmPassword.isEmpty
        else {
            showAlert(message: "Lütfen tüm alanları doldurunuz.")
            return
        }
        
        let paramsSignUp = ["full_name": name, "email": email, "password": password]
        
        viewModel.signUp(params: paramsSignUp, completion: { result in
            switch result {
                case .success(_):
                    self.showAlertSuccess(message:"Kayıt başarılı.")
                case .failure(_):
                    self.showAlertError(message: "Zaten var olan bir kullanıcı")
            }
        })
    }
    
    
    // MARK: ShowAlert
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlertSuccess(message: String) {
        let alertController = UIAlertController(title: "Başarılı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default) { [weak self] _ in
            self?.navigateToLoginViewController()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlertError(message: String) {
        let alertController = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
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
        setupViews()
    }
    
    private lazy var loginItemStackView = createStackView(axis: .vertical, spacing: 24)
    
    private lazy var signUpText = createLabel(text: "Sign Up", color: "textFieldBackgroundColor", textSize: 36, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var errorLabel = createLabel(text: "", color: "", textSize: 14, fontName: "Poppins-Regular", alignment: .center)
    
    private lazy var usernameTextField = addTextField(title: "Username", placeholder: "deneme_name", keyboardType: .default, isSecure: false)
    private lazy var emailTextField = addTextField(title: "Email", placeholder: "deneme@example.com", keyboardType: .emailAddress, isSecure: false)
    private lazy var passwordTextField = addTextField(title: "Password", placeholder: "", keyboardType: .default, isSecure: true)
    private lazy var passwordConfirmTextField = addTextField(title: "Password Confirm", placeholder: "", keyboardType: .default, isSecure: true)
    
    
    
    private func setupViews() {
        
        self.view.addSubviews(loginView,loginItemView,signUpText,backButton,errorLabel)
        
        loginItemView.addSubviews(loginItemStackView,signUpButton)
        
        loginItemStackView.addArrangedSubviews(usernameTextField,emailTextField,passwordTextField,passwordConfirmTextField)
        
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        loginView.snp.makeConstraints({loginView in
            loginView.edges.equalToSuperview()
            loginView.top.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        signUpText.snp.makeConstraints({text in
            text.centerX.equalTo(loginView)
            text.bottom.equalTo(loginItemView.snp.top).offset(-56)
            
        })
        
        loginItemView.snp.makeConstraints({itemView in
            itemView.top.bottom.equalTo(loginView).offset(164)
            itemView.left.right.equalTo(loginView)
        })
        
        usernameTextField.snp.makeConstraints { $0.height.equalTo(74) }
        usernameTextField.snp.makeConstraints { $0.width.equalTo(392) }
        
        emailTextField.snp.makeConstraints { $0.height.equalTo(74) }
        emailTextField.snp.makeConstraints { $0.width.equalTo(392) }
        
        passwordTextField.snp.makeConstraints { $0.height.equalTo(74) }
        passwordTextField.snp.makeConstraints { $0.width.equalTo(392) }
        
        passwordConfirmTextField.snp.makeConstraints { $0.height.equalTo(74) }
        passwordConfirmTextField.snp.makeConstraints { $0.width.equalTo(392) }
        
        
        loginItemStackView.dropShadow()
        loginItemStackView.snp.makeConstraints({stack in
            stack.left.right.equalTo(loginItemView).inset(24)
            stack.top.equalTo(loginItemView.snp.top).offset(72)
        })
        
        signUpButton.snp.makeConstraints({button in
            button.height.equalTo(54)
            button.width.equalTo(342)
            
            button.left.right.equalTo(loginItemStackView)
            button.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-23)
        })
        
        
        backButton.snp.makeConstraints({button in
            button.centerY.equalTo(signUpText)
            button.left.equalTo(loginItemStackView).offset(12)
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
