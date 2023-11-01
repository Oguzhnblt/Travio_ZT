//
//  GetLastPlacesResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation

struct GetLastPlacesResponse: Codable {
    struct Data: Codable {
           var count: Int?
           var places: [Place]?
       }

       var data: Data?
       var status: String?
}
