//
//  LoginViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation

class LoginViewModel {
    
    func login(params: [String: Any],completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        NetworkingHelper.shared.fetchData(urlRequest: .login(params: params), callback: completion)
    }
}
