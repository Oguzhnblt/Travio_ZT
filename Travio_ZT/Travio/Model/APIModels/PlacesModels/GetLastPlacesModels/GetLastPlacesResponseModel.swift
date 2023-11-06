//
//  GetLastPlacesResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation


    struct GetLastPlacesData: Codable {
           var count: Int?
           var places: [Place]?
       }
struct GetLastPlacesResponse: Codable {
       var data: GetLastPlacesData?
       var status: String?
}
