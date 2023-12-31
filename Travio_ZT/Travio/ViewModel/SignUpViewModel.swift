//
//  SignUpViewModel.swift
//  Travio
//
//  Created by web3406 on 2.11.2023.
//

import Foundation

class SignUpViewModel {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var passwordConfirm: String = ""

    func isSignUpEnabled() -> Bool {
        return !name.isEmpty && arePasswordsEqual()
    }
    private func arePasswordsEqual() -> Bool {
        return password == passwordConfirm
    }

    func signUp() {
        if isSignUpEnabled() {
            let paramsSignUp = ["full_name": name, "email": email, "password": password]

            NetworkingHelper.shared.fetchData(urlRequest: .register(params: paramsSignUp)) { (result: Result<RequestModel, Error>) in
                
                print(result)
            }
        } else {
            
        }
    }
}

