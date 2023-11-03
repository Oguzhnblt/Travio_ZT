//
//  GetAllGalleryByPlaceIdResponseModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation

    struct GetAllGalleryByPlaceIdData: Codable {
            var count: Int?
            var images: [Image]?
        }
struct GetAllGalleryByPlaceIdResponse: Codable {
        let data: GetAllGalleryByPlaceIdData?
        let status: String?
}
