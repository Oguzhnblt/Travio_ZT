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
    var checking: ((String) -> Void)?
    var userCheck: (([Place]) -> Void)?
    var showAlert: ((String) -> Void)?

     func getAllGalleries(placeId: String) { 
         NetworkingHelper.shared.fetchData(urlRequest: .getAllGalleryByPlaceId(placeId: placeId)) {[weak self] (result: Result<GetAllGalleryByPlaceIdResponse,Error>) in
            switch result {
                case .success(let success):
                    self?.imageData?((success.data?.images)!)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    
    func postVisit(params: [String: Any?]) {
        NetworkingHelper.shared.fetchData(urlRequest: .postVisit(params: params as Parameters)) {(result: Result<GenericResponseModel,Error>) in
           switch result {
               case .success(_): break
               case .failure(let failure):
                   print(failure.localizedDescription)
           }
       }
   }
    
    func deleteVisit(placeID: String?) {
        NetworkingHelper.shared.fetchData(urlRequest: .deleteVisitByPlaceId(placeId: placeID!)) {(result: Result<GenericResponseModel,Error>) in
           switch result {
               case .success(_): break
               case .failure(let failure):
                   print(failure.localizedDescription)
           }
       }
   }
    
    func checkVisitsById(placeID: String) {
        NetworkingHelper.shared.fetchData(urlRequest: .checkVisitByPlaceId(placeId: placeID)) { [weak self](result: Result<GenericResponseModel, Error>) in
            switch result {
                case .success(let success):
                    self?.checking?(success.status!)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    
    func checkForUser() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlacesForUser) {[weak self](result: Result<GetAllPlacesForUserResponse, Error>)in
            switch result {
                case .success(let success):
                    self?.userCheck?((success.data?.places)!)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    
    func deletePlace(placeId: String) {
        NetworkingHelper.shared.fetchData(urlRequest: .deletePlace(placeId: placeId)) {[weak self](result: Result<GenericResponseModel, Error>)in
            switch result {
                case .success(let success):
                    self?.showAlert?(success.message!)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}
