//
//  MapVM.swift
//  Travio
//
//  Created by Oğuz on 8.11.2023.
//

import Foundation

class MapVM {
    
    var dataTransfer: (([Place]) -> Void)?
    
    func mapPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlaces) { [self] (result: Result<GetAllPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    self.dataTransfer?((object.data?.places)!)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
}
