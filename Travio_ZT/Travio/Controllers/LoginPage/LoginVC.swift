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
    
    private func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.numberOfLines = 1
        label.textAlignment = alignment
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    
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
    
    private lazy var welcomeLabelText = createLabel(text: "Welcome to Travio", color: "textColor" , textSize: 24, fontName: "Poppins-Regular", alignment: .center)
    private lazy var accountLabel = createLabel(text: "Don’t have any account?", color: "textColor" , textSize: 14, fontName: "Poppins-SemiBold", alignment: .center)
    
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
        loginView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { image in
            image.width.equalTo(149)
            image.height.equalTo(178)
            image.centerX.equalTo(loginView)
            image.top.equalTo(self.view.safeAreaLayoutGuide)
            image.bottom.equalTo(loginItemView.snp.top).offset(-24)
        }
        
        loginItemView.snp.makeConstraints { viewField in
            viewField.width.height.equalToSuperview()
        }
        
        welcomeLabelText.snp.makeConstraints { text in
            text.top.equalTo(loginItemView).offset(64)
            text.leading.trailing.equalTo(loginItemView)
        }
        
        
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }

        loginİtemStackView.dropShadow()
        loginİtemStackView.snp.makeConstraints { textField in
            textField.top.equalTo(welcomeLabelText.snp.bottom).offset(41)
            textField.left.right.equalTo(loginButton)
        }
        
        loginButton.snp.makeConstraints { button in
            button.top.equalTo(loginİtemStackView.snp.bottom).offset(48)
            button.leading.trailing.equalToSuperview().inset(24)
            button.height.equalTo(54)
            button.width.equalTo(342)
        }
        
        signUpStackView.snp.makeConstraints { sign in
            sign.centerX.equalToSuperview()
            sign.bottom.equalTo(self.view.safeAreaLayoutGuide)
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
