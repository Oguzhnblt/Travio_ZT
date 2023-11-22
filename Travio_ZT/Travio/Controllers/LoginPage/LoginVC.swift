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
    
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "travio_icon")
        
        return imageView
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(named: "textColor"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func signUpTapped() {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func buttonLoginTapped() {
        
        guard let email = emailTextField.textField.text,
              let password = passwordTextField.textField.text
                
        else {return}
        
        guard viewModel.isValidEmail(email) else {
            Alerts.showAlert(from: self, title: "Hata", message: "Geçersiz email", actionTitle: "Tamam")
                    return
                }
        
        viewModel.login(email: email, password: password)
        
        viewModel.navigateToViewController = {
            self.navigateToHomeVC()
        }
        viewModel.showAlertFailure = { message in
            Alerts.showAlert(from: self, title: "Hata", message: message, actionTitle: "Tamam")
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
    
    
    private lazy var loginİtemStackView = createStackView(axis: .vertical, spacing: 24)
    private lazy var signUpStackView = createStackView(axis: .horizontal, spacing: 4)

    private lazy var accountLabel = LabelUtility.createLabel(text: "Don’t have any account?", color: "textColor" , textSize: 14, fontName: "Poppins-SemiBold", alignment: .center)
    
    private lazy var welcomeLabelText = LabelUtility.createLabel(text: "Welcome to Travio", color: "textColor", textSize: 24, fontName: "Poppins-Regular", alignment: .center)
        
    private lazy var emailTextField = CommonTextField(labelText: "Email", textFieldPlaceholder: "deneme@example.com", isSecure: false)
    
    private lazy var passwordTextField = CommonTextField(labelText: "Password", textFieldPlaceholder: "************", isSecure: true)
    
    private lazy var loginButton = ButtonUtility.createButton(from: self, title: "Login", action: #selector(buttonLoginTapped))
    
    private func setupViews() {
        self.view.addSubviews(loginView,loginItemView,imageView)
        
        loginItemView.addSubviews(loginİtemStackView,welcomeLabelText,signUpStackView,loginButton)
        
        loginİtemStackView.addArrangedSubviews(emailTextField,passwordTextField)
        signUpStackView.addArrangedSubviews(accountLabel,signUpButton)
        
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let squareRatio: CGFloat = 0.35

        let squareSize = min(screenWidth, screenHeight) * squareRatio
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(squareSize)
            make.centerX.equalTo(loginView)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(loginItemView.snp.top).offset(-24)
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

        loginİtemStackView.dropShadow()
        loginİtemStackView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabelText.snp.bottom).offset(41)
            make.left.right.equalTo(loginButton)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(signUpStackView.snp.top).offset(-30)
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
        
        LoginVC().showPreview()
    }
}
#endif
