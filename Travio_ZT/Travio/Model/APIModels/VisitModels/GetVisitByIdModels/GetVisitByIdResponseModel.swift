//
//  GetVisitByIdResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 2.11.2023.
//

import Foundation
struct GetVisitByIdResponse: Codable {
    struct Data: Codable {
        var visit: Visit?
    }

    let data: Data?
    let status: String?
}
