//
//  ImageModel.swift
//  Travio
//
//  Created by HIKMET KURU on 1.11.2023.
//

import Foundation

struct Image: Codable,Identifiable {
    var id: String?
        var place_id: String?
        var image_url: String?
        var created_at: String?
        var updated_at: String?
}
