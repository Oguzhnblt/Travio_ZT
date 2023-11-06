//
//  SignUpViewModel.swift
//  Travio
//
//  Created by Oğuz on 6.11.2023.
//

import Foundation

class SignUpViewModel {
    
    func signUp(params: [String: Any], completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        NetworkingHelper.shared.fetchData(urlRequest: .register(params: params)) { (result: Result<RegisterResponse, Error>) in
            switch result {
            case .success(let success):
                // completion(.success(success))
                completion(.success(success))
            case .failure(let failure):
                // completion(.failure(failure))
                completion(.failure(failure))
            }
        }
    }
}

