//
//  LoginViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation

class LoginVM {
    
    var showAlertSuccess: ((String) -> Void)?
    var showAlertFailure: ((String) -> Void)?
    var navigateToViewController: (() -> Void)?
    var loginSuccessCallback: ((String) -> Void)?


    
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            showAlertFailure?("Email ve şifre boş bırakılamaz.")
            return
        }
        
        let params = ["email": email, "password": password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .login(params: params)) { [weak self] (result: Result<LoginResponse, Error>) in
            switch result {
                case .success(let loginResponse):
                    self?.showAlertSuccess?("Login successful")
                    self?.loginSuccessCallback?(loginResponse.access_token!)
                    self?.navigateToViewController?()
                case .failure(_):
                    self?.showAlertFailure!("Email ve şifre hatalı.")
            }
        }
    }
}

