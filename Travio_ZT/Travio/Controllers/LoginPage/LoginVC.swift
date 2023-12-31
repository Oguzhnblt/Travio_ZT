//
//  ViewController.swift
//  Travio
//
//  Created by Oğuz on 14.10.2023.
//

import Foundation
import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    private let viewModel = LoginVM()
    weak var previousViewController: UIViewController?
    private lazy var activityIndicator = ActivityIndicatorManager()

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
        view.backgroundColor = AppTheme.getColor(name: .background)
        return view
    }()
    
    
    private lazy var loginItemView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.getColor(name: .content)
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "travio_icon")
        return imageView
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(AppTheme.getColor(name: .general), for: .normal)
        button.titleLabel?.font = AppTheme.getFont(name: .semibold, size: .size14)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func signUpTapped() {
        let vc = SignUpVC()
        vc.signUpSuccessCallback = { [weak self] (email, password) in
            self?.emailTextField.textField.text = email
            self?.passwordTextField.textField.text = password
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func buttonLoginTapped() {
        
        guard let email = emailTextField.textField.text,
              let password = passwordTextField.textField.text
        else {return}
        
        guard isValidEmail(email) else {
            showAlert(title: "Hata", message: "Geçersiz email", actionTitle: "Tamam")
            return
        }
        
        viewModel.login(email: email, password: password)
        activityIndicator.start(in: view, text: "Giriş Yapılıyor...")
        
        viewModel.navigateToViewController = { [weak self] in
            self?.navigateToHomeVC()
            self?.activityIndicator.stop()
        }
        
        viewModel.showAlertFailure = { message in
            self.activityIndicator.stop()
            self.showAlert(title: "Hata", message: message, actionTitle: "Tamam")
        }
    }
    
    private func navigateToHomeVC() {
        let homeVC = MainTabbarVC()
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    private lazy var loginItemStackView = createStackView(axis: .vertical, spacing: 24)
    private lazy var signUpStackView = createStackView(axis: .horizontal, spacing: 4)
    
    private lazy var accountLabel = createLabel(text: "Don’t have any account?" , textSize: .size14, fontType: .semibold, alignment: .center)
    
    private lazy var welcomeLabelText = createLabel(text: "Welcome to Travio", textSize: .size24, fontType: .medium, alignment: .center)
    
    private lazy var emailTextField = CommonTextField(labelText: "Email", textFieldPlaceholder: "deneme@example.com", isSecure: false)
    
    private lazy var passwordTextField = CommonTextField (labelText: "Şifre", textFieldPlaceholder: "************", isSecure: true)
    
    
    
    private lazy var loginButton = createButton(title: "Login", action: #selector(buttonLoginTapped))
    
    private func setupViews() {
        self.view.addSubviews(loginView,loginItemView,imageView)
        
        loginItemView.addSubviews(loginItemStackView,welcomeLabelText,signUpStackView,loginButton)
        
        loginItemStackView.addArrangedSubviews(emailTextField,passwordTextField)
        signUpStackView.addArrangedSubviews(accountLabel,signUpButton)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(loginItemView.snp.top).offset(-24)
            
            let imageSizePercentage: CGFloat = 0.15
            make.width.equalTo(view.snp.height).multipliedBy(imageSizePercentage)
            make.height.equalTo(view.snp.height).multipliedBy(imageSizePercentage * (178.0 / 149.0))
          
        }
        
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginItemView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        welcomeLabelText.snp.makeConstraints { make in
            make.top.equalTo(loginItemView).offset(64)
            make.leading.trailing.equalTo(loginItemView)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        loginItemStackView.dropShadow()
        loginItemStackView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabelText.snp.bottom).offset(41)
            make.left.right.equalTo(loginButton)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(signUpStackView.snp.top).offset(-10)
            make.height.equalTo(54)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct LoginVC_Preview: PreviewProvider {
    static var previews: some View{
        
        LoginVC().showPreview().ignoresSafeArea()
    }
}
#endif

