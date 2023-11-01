//
//  GetAllPlacesResponseModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct GetAllPlacesResponse: Codable {

    struct Data: Codable {
            var count: Int?
            var places: [Place]?
        }

        var data: Data?
        var status: String?
}
