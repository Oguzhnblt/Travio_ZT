//
//  EditProfileRequestModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct EditProfileRequest: Codable {
    var full_name: String
    var email: String
    var pp_url: String
}
