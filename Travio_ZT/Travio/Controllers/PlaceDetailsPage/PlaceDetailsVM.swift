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
                    print(failure.localizedDescription)
            }
        })
    }
    
    func postVisit(params: [String: Any?]) {
        NetworkingHelper.shared.fetchData(urlRequest: .postVisit(params: params as Parameters), completion: {(result: Result<PostVisitResponse,Error>) in
           switch result {
               case .success(let success):
                   print(success.message!)
               case .failure(let failure):
                   print(failure.localizedDescription)
           }
       })
   }
    
    func deleteVisit(placeID: String?) {
        NetworkingHelper.shared.fetchData(urlRequest: .deleteVisitByPlaceId(placeId: placeID!), completion: {(result: Result<DeleteVisitByPlaceIdResponse,Error>) in
           switch result {
               case .success(let success):
                   print(success.message!)
               case .failure(let failure):
                   print(failure.localizedDescription)
           }
       })
   }
    
}
