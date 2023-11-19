//
//  PopularPlacesVM.swift
//  Travio
//
//  Created by Oğuz on 8.11.2023.
//

import Foundation
import UIKit

class GenericPlacesVM {
    
    var popularplacesTransfer: (([Place]) -> Void)?
    var lastPlacesTransfer: (([Place]) -> Void)?
    var addedPlacesTransfer: (([Place]) -> Void)?
    
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
    
    func myAddedPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlacesForUser) { [self] (result: Result<GetAllPlacesForUserResponse, Error>) in
            switch result {
                case .success(let object):
                    self.addedPlacesTransfer?((object.data?.places)!)
                case .failure(let failure):
                    print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func imageCorrect(imageView: UIImageView, url: URL?) {
        guard let url = url else {
            return
        }

        imageView.kf.setImage(with: url) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                imageView.image = UIImage(named: "img_default")
            }
        }
    }
}
