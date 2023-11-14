//
//  UploadResponseModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct UploadResponse: Codable {
    var messageType: String?
    var message: String?
    var urls: [String]
}
