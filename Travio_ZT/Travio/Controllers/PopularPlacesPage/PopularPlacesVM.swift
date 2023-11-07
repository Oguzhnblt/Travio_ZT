//
//  PopularPlacesVM.swift
//  Travio
//
//  Created by Oğuz on 8.11.2023.
//

import Foundation

class PopularPlacesVM {
    
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
}
