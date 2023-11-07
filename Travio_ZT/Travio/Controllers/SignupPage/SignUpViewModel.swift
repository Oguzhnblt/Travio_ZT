//
//  SignUpViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation

class SignUpViewModel {
    
    var showAlertSuccess: ((String) -> Void)?
    var showAlertFailure: ((String) -> Void)?
    
    
    func signUp(fullName: String,email: String, password: String) {
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty
        else {
            showAlertFailure?("Lütfen tüm alanları doldurunuz.")
            return
        }
        
        let params = ["full_name": fullName,"email": email,"password": password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .register(params: params)) { [weak self] (result: Result<RegisterResponse, Error>) in
            switch result {
                case .success(_):
                    self?.showAlertSuccess!("Login successful")
                case .failure(_):
                    self?.showAlertFailure!("Email ve şifre hatalı.")
            }
        }
    }
}

