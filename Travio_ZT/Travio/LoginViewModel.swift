//
//  LoginViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    func login(completion: @escaping (Result<LoginResponse, Error>) -> Void) {
            let paramsLogin = ["email": email, "password": password]
            NetworkingHelper.shared.fetchData(urlRequest: .login(params: paramsLogin), callback: completion)
        }
}
