//
//  MapVM.swift
//  Travio
//
//  Created by Oğuz on 8.11.2023.
//

import Foundation
import UIKit

class MapVM {
    
    var dataTransfer: (([Place]) -> Void)?
    
    func mapPlaces() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlaces) { [weak self] (result: Result<GetAllPlacesResponse, Error>) in
            switch result {
                case .success(let object):
                    self?.dataTransfer?((object.data?.places)!)
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
                    imageView.image = UIImage(named: "img_default") ?? UIImage()
                }
            }
        }
}
