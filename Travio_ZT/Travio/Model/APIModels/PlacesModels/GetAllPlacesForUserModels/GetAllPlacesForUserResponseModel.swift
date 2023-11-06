//
//  GetAllPlacesForUserResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation
struct GetAllPlacesForUserData: Codable {
            let count: Int?
            let places: [Place]?
        }

struct getAllPlacesForUserResponse: Codable{
        let data: GetAllPlacesForUserData?
        let status: String?
}
