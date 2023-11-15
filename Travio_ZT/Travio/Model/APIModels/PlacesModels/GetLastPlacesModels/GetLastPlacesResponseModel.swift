//
//  GetLastPlacesResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation


struct GetLastPlacesData: Codable {
    var count: Int?
    var places: [PlaceLast]?
}

struct GetLastPlacesResponse: Codable {
    var data: GetLastPlacesData?
    var status: String?
}


