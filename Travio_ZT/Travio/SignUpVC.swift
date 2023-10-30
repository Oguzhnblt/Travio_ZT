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
    
    private lazy var  backButton: UIButton = {
        let buttonImage = UIImage(named: "leftArrowIcon")
        let imageButton = UIButton(type: .system)
        imageButton.setImage(buttonImage, for: .normal)
        imageButton.tintColor = .white
        
        let customBackButtonItem = UIBarButtonItem(customView: imageButton)
        navigationItem.leftBarButtonItem = customBackButtonItem
        
        imageButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return imageButton
    }()
    
    
    @objc private func backButtonTapped() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func signUpButtonTapped() {
        
        guard let name = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text
        else {return}
        let paramsSignUp = ["full_name" : name, "email" : email, "password" : password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .register(params: paramsSignUp), callback:  { (result:Result<RequestModel,Error>) in
        
        print(result)
    })

    }
    
//    @objc private func textFieldDidChange(_ textField: UITextField) {
//        let isAllFieldsFilled = !(usernameTextField.text?.isEmpty ?? true) &&
//                                !(emailTextField.text?.isEmpty ?? true) &&
//                                !(passwordTextField.text?.isEmpty ?? true) &&
//                                !(passwordConfirmTextField.text?.isEmpty ?? true)
//
//        signUpButton.isEnabled = isAllFieldsFilled
//        signUpButton.backgroundColor = isAllFieldsFilled ? UIColor(named: "backgroundColor") : UIColor.lightGray
//    }
//
//    private func didChange() {
//        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            passwordConfirmTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        didChange()
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
<<<<<<< HEAD
struct SignUp_Preview: PreviewProvider {
=======
struct SignUpVC_Preview: PreviewProvider {
>>>>>>> f88ea6e6d0c975a2648bf0f4199d658ad254afb1
    static var previews: some View{
         
        SignUpVC().showPreview()
    }
}
#endif
