//
//  LoginViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation

class LoginViewModel {
    
    var showAlertSuccess: ((String) -> Void)?
    var showAlertFailure: ((String) -> Void)?
    var navigateToViewController: (() -> Void)?

    
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            showAlertFailure?("Email ve şifre boş bırakılamaz.")
            return
        }
        
        let params = ["email": email, "password": password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .login(params: params)) { [weak self] (result: Result<LoginResponse, Error>) in
            switch result {
                case .success(_):
                    self?.showAlertSuccess?("Login successful")
                    self?.navigateToViewController?()
                case .failure(_):
                    self?.showAlertFailure!("Email ve şifre hatalı.")
            }
        }
    }
}

