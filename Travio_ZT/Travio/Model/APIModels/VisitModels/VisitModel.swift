//
//  VisitModel.swift
//  Travio
//
//  Created by HIKMET KURU on 2.11.2023.
//

import Foundation
struct Visit: Codable, Identifiable{
    var id: String?
        var place_id: String?
        var visited_at: String?
        var created_at: String?
        var updated_at: String?
        var place: Place?
}
