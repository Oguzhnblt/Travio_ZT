//
//  GetAllPlacesForUserResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation
struct GetAllPlacesForUserResponse: Codable {
    struct Data: Codable {
            let count: Int?
            let places: [Place]?
        }

        let data: Data?
        let status: String?
}
