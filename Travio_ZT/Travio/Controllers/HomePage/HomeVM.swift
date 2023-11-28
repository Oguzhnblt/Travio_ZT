//
//  HomePagePlacesModel.swift
//  Travio
//
//  Created by Oğuz on 7.11.2023.
//

import Foundation

class HomeVM {
    
    var popularPlacesTransfer: (([Place]) -> Void)?
    var lastPlacesTransfer: (([Place]) -> Void)?
    var addedPlacesTransfer: (([Place]) -> Void)?
    
    func popularPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getPopularPlaces(limit: 3)) { [weak self] (result: Result<GetPopularPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    guard let places = object.data?.places else {return}
                    self?.popularPlacesTransfer?(places)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func newPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getLastPlaces(limit: 3)) { [weak self] (result: Result<GetLastPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    guard let places = object.data?.places else {return}
                    self?.lastPlacesTransfer?(places)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func myAddedPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlacesForUser) { [weak self] (result: Result<GetAllPlacesForUserResponse, Error>) in
            switch result {
                case .success(let object):
                    guard let places = object.data?.places else {return}
                    self?.addedPlacesTransfer?(places)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
}
