//
//  PopularPlacesModel.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation

struct PlacesModel {
    
    var cover_img_url: String?
    var title: String?
    var place: String?
}

var popularPlacesMockData = [
    PlacesModel(cover_img_url: "img_pyramid", title: "Mısır Piramitleri", place: "Kahire"),
    PlacesModel(title: "Babil Asma Bahçeleri", place: "Irak"),
    PlacesModel(cover_img_url: "img_colleseum", title: "Colleseum", place: "Rome"),
    PlacesModel(cover_img_url: "img_suleymaniye", title: "Süleymaniye Camii", place: "İstanbul"),
    PlacesModel(cover_img_url: "img_eiffel",title: "Eyfel Kulesi", place: "Paris"),
    PlacesModel(cover_img_url: "img_statue_of_liberty", title: "Özgürlük Heykeli", place: "New York"),
    PlacesModel(cover_img_url: "img_taj_mahal", title: "Taj Mahal", place: "Agra"),
    PlacesModel(cover_img_url: "img_golden_gate_bridge", title: "Golden Gate Köprüsü", place: "San Francisco"),
    PlacesModel(cover_img_url: "img_big_ben", title: "Big Ben", place: "London"),
    PlacesModel(cover_img_url: "img_petra", title: "Petra", place: "Jordan"),
    PlacesModel(cover_img_url: "img_machu_picchu", title: "Machu Picchu", place: "Peru"),
    PlacesModel(cover_img_url: "img_sydney_opera_house", title: "Sydney Opera House", place: "Sydney"),
]

var newPlacesMockData = [
    PlacesModel(cover_img_url: "img_eiffel" ,title: "Eyfel Kulesi", place: "Paris"),
    PlacesModel(cover_img_url: "img_suleymaniye", title: "Süleymaniye Camii", place: "İstanbul"),
    PlacesModel(cover_img_url: "img_colleseum", title: "Colleseum", place: "Rome"),
    PlacesModel(cover_img_url: "img_colleseum", title: "Colleseum", place: "Rome"),
]

