//
//  GetAllVisitsResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 2.11.2023.
//

import Foundation

    struct GetAllVisitsData: Codable {
            var count: Int?
            var visits: [Visit]
        }
struct GetAllVisitsResponse: Codable {
        var data: GetAllVisitsData?
        var status: String?
}
