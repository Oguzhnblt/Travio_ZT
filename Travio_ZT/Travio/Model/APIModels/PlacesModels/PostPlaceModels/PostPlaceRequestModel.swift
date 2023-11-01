//
//  PostPlaceRequestModel.swift
//  Travio
//
//  Created by web3406 on 1.11.2023.
//

import Foundation

struct PostPlaceRequest: Codable {
    var place: String
    var title: String
    var description: String
    var cover_image_url: String
    var latitude: Double
    var longitude: Double
    
}
