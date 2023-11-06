//
//  RegisterRequestModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct RegisterRequest : Codable {
    var full_name:String?
    var email: String?
    var password: String?
    
    init(full_name: String? = nil, email: String? = nil, password: String? = nil) {
        self.full_name = full_name
        self.email = email
        self.password = password
    }
}
