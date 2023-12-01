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
    
    
    func login(email: String, password: String) {
       
        let params = ["email": email, "password": password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .login(params: params)) { [weak self] (result: Result<LoginResponse, Error>) in
            switch result {
                case .success(let loginResponse):
                    AccessManager.shared.saveToken(loginResponse.accessToken, accountIdentifier: "access-token")
                    self?.navigateToViewController?()
                case .failure(_):
                    self?.showAlertFailure!("Email veya şifre hatalı.")
            }
        }
    }
}


