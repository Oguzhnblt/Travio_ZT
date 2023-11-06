//
//  GetPopularPlacesResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation

struct GetPopularPlacesResponse: Codable {
        let data: PopularPlacesData
        let status: String
    }

    struct PopularPlacesData: Codable {
        let count: Int
        let places: [Place]
    }

