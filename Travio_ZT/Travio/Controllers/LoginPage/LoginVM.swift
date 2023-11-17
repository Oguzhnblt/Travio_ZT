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
    
    func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
                   showAlertFailure?("Email ve şifre boş bırakılamaz.")
                   return
               }

        guard !email.isEmpty, !password.isEmpty else {
            showAlertFailure?("Email ve şifre boş bırakılamaz.")
            return
        }
        
        let params = ["email": email, "password": password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .login(params: params)) { [weak self] (result: Result<LoginResponse, Error>) in
            switch result {
                case .success(let loginResponse):
                    AccessManager.shared.saveToken(loginResponse.accessToken, accountIdentifier: "access-token")
                    self?.navigateToViewController?()
                case .failure(_):
                    self?.showAlertFailure!("Email ve şifre hatalı.")
            }
        }
    }
}


