//
//  PopularPlacesModel.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation

struct PopularPlacesModel {
    var covere_img_url: String?
    var title: String?
    var place: String?
}

var popularPlacesMockData = [
    PopularPlacesModel(covere_img_url: "img_colleseum", title: "Colleseum", place: "Rome"),
    PopularPlacesModel(covere_img_url: "img_suleymaniye", title: "Süleymaniye Camii", place: "İstanbul"),
    PopularPlacesModel(title: "Süleymaniye Camii", place: "İstanbul"),
  
]

