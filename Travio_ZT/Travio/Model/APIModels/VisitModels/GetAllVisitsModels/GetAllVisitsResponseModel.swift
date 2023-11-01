//
//  GetAllVisitsResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 2.11.2023.
//

import Foundation
struct GetAllVisitsResponse: Codable {
    struct Data: Codable {
            var count: Int?
            var visits: [Visit]
        }

        var data: Data?
        var status: String?
}
