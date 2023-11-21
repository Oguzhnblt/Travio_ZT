//
//  SignUpViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation

class SignUpVM {
    
    var showAlertSuccess: ((String) -> Void)?
    var showAlertFailure: ((String) -> Void)?
    
    func signUp(fullName: String,email: String, password: String, confirmPassword: String) {
        guard !fullName.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty
        else {
            showAlertFailure?("Lütfen tüm alanları doldurunuz.")
            return
        }
        
        if password != confirmPassword {
            showAlertFailure?("Parolalar eşleşmiyor")
            return
        }

        
        let params = ["full_name": fullName,"email": email,"password": password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .register(params: params)) { [weak self] (result: Result<GenericResponseModel, Error>) in
            switch result {
                case .success(_):
                    self?.showAlertSuccess!("Kayıt işlemi başarılı")
                case .failure(_):
                    self?.showAlertFailure!("Email ve şifre hatalı.")
            }
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

