//
//  PopularPlacesVM.swift
//  Travio
//
//  Created by Oğuz on 8.11.2023.
//

import Foundation

class GenericPlacesVM {
    
    var popularplacesTransfer: (([Place]) -> Void)?
    var lastPlacesTransfer: (([Place]) -> Void)?
    
    func popularPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getPopularPlaces(limit: 100)) { [self] (result: Result<GetPopularPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    self.popularplacesTransfer?((object.data?.places!)!)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func newPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getLastPlaces(limit: 100)) { [self] (result: Result<GetLastPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    self.lastPlacesTransfer?((object.data?.places)!)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
}
