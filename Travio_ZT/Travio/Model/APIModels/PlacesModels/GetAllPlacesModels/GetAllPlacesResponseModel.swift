//
//  GetAllPlacesResponseModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation


struct GetAllPlacesData: Codable {
            var count: Int?
            var places: [Place]?
        }
struct GetAllPlacesResponse: Codable {
        var data: GetAllPlacesData?
        var status: String?
}
