//
//  GetAllGalleryByPlaceIdResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation
struct GetAllGalleryByPlaceIdResponse: Codable {
    struct Data: Codable {
            var count: Int?
            var images: [Image]?
        }

        let data: Data?
        let status: String?
}
