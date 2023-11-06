//
//  GetVisitByIdResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 2.11.2023.
//

import Foundation

    struct GetVisitByIdData: Codable {
        var visit: Visit?
    }
struct GetVisitByIdResponse: Codable {
    let data: GetVisitByIdData?
    let status: String?
}
