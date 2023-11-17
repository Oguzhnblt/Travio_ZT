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
    var visitsTransfer: (([Visit]) -> Void)?
    var checking: ((String) -> Void)?

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
               case .success(_): break
                  
               case .failure(let failure):
                   print(failure.localizedDescription)
           }
       })
   }
    
    func deleteVisit(placeID: String?) {
        NetworkingHelper.shared.fetchData(urlRequest: .deleteVisitByPlaceId(placeId: placeID!), completion: {(result: Result<DeleteVisitByPlaceIdResponse,Error>) in
           switch result {
               case .success(_): break
               case .failure(let failure):
                   print(failure.localizedDescription)
           }
       })
   }
    func getAllVisits() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllVisits, completion: { [self](result: Result<GetAllVisitsResponse, Error>) in
            switch result {
                case .success(let success):
                    visitsTransfer?(success.data!.visits)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        })
    }
    
    func checkVisitsById(placeID: String) {
        NetworkingHelper.shared.fetchData(urlRequest: .checkVisitByPlaceId(placeId: placeID), completion: { [self](result: Result<CheckVisitByPlaceIdResponse, Error>) in
            switch result {
                case .success(let success):
                    checking?(success.status!)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        })
    }
    
}
