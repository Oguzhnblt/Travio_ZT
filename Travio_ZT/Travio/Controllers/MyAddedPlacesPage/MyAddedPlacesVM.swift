//
//  MyAddedPlacesVM.swift
//  Travio
//
//  Created by Oğuz on 18.11.2023.
//

import Foundation

class MyAddedPlacesVM {
    
    var myAddedTransfer: (([Place]) -> Void)?
    
    func getMyAddedPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlacesForUser, completion: { [weak self] (result: Result<GetAllPlacesForUserResponse, Error>) in
            switch result {
                case .success(let success):
                    guard let places = success.data?.places else {return}
                    self?.myAddedTransfer?(places)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        })
    }
    
}
