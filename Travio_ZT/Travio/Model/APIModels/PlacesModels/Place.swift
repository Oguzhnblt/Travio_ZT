//
//  PlaceModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation

struct Place: Codable,Identifiable {
    var id: String?
    var creator: String?
    var place: String?
    var title: String?
    var description: String?
    var cover_image_url: String?
    var latitude: Double?
    var longitude: Double?
    var created_at: String?
    var updated_at: String?
}

