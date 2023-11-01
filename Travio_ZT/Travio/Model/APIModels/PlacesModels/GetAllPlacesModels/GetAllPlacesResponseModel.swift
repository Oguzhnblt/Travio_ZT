//
//  GetAllPlacesResponseModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct GetAllPlacesResponse: Codable {
        var id: String
        var creator: String
        var place: [PostPlaceRequest]
        var status: String
        
}
