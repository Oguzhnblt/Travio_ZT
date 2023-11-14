//
//  PlaceDetailsVM.swift
//  Travio
//
//  Created by Oğuz on 13.11.2023.
//

import Foundation
import Alamofire

class PlaceDetailsVM {
    var imageData: (([PlaceImage]) -> Void)?

     func getAllGalleries(placeId: String) {
         NetworkingHelper.shared.fetchData(urlRequest: .getAllGalleryByPlaceId(placeId: placeId), completion: {(result: Result<GetAllGalleryByPlaceIdResponse,Error>) in
            switch result {
                case .success(let success):
                    self.imageData?((success.data?.images)!)
                case .failure(let failure):
                    print(failure)
            }
        })
    }
    
}
