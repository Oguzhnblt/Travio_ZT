//
//  RefreshResponseModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct RefreshResponse: Codable {
    var accessToken: String?
    var refreshToken: String?
}
