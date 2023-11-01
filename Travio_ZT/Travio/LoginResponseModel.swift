//
//  LoginResponseModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
