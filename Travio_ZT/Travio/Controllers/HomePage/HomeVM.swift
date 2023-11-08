//
//  HomePagePlacesModel.swift
//  Travio
//
//  Created by Oğuz on 7.11.2023.
//

import Foundation

class HomeVM {
        
    var dataTransfer: (([Place]) -> Void)?
    
    func popularPlaces(limit: Int) {
        NetworkingHelper.shared.fetchData(urlRequest: .getPopularPlaces(limit: limit)) { [self] (result: Result<GetPopularPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    self.dataTransfer?((object.data?.places!)!)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func newPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getLastPlaces(limit: 2)) { [self] (result: Result<GetLastPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    self.dataTransfer?((object.data?.places)!)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
}