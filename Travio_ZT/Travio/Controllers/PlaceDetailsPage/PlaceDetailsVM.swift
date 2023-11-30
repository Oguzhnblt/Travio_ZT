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
    
    var errorMessage: ((String) -> Void)?
    var successMessage: ((String, String?) -> Void)?
    
    func getAllGalleries(placeId: String) {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllGalleryByPlaceId(placeId: placeId)) {[weak self] (result: Result<GetAllGalleryByPlaceIdResponse,Error>) in
            switch result {
                case .success(let success):
                    self?.imageData?((success.data?.images)!)
                case .failure(let failure):
                    self?.errorMessage!(failure.localizedDescription)
            }
        }
    }
    
    func postVisit(placeId: String) {
        let visitedAt = DateFormatter.formattedString()
        let params = ["place_id": placeId, "visited_at": visitedAt]

        NetworkingHelper.shared.fetchData(urlRequest: .postVisit(params: params)) {(result: Result<GenericResponseModel,Error>) in
            switch result {
                case .success(let success):
                    if success.status == "success" {
                        let title = "💖"
                        let message = "Ziyaretlere eklendi"
                        self.successMessage?(message, title)
                    }
                    else {
                        let message = "Bir sorun oluştu. Lütfen tekrar deneyiniz."
                        self.errorMessage?(message)
                    }
                case .failure(_): break
                    
            }
        }
    }
   
    func deleteVisit(placeID: String?) {
        NetworkingHelper.shared.fetchData(urlRequest: .deleteVisitByPlaceId(placeId: placeID!)) {(result: Result<GenericResponseModel,Error>) in
            switch result {
                case .success(let success):
                    if success.status == "success" {
                        let title = "💔"
                        let message = "Ziyaretlerden kaldırıldı."
                        self.successMessage?(message, title)
                    } else {
                        let message = "Bir sorun oluştu lütfen tekrar deneyiniz."
                        self.errorMessage?(message)
                    }
                case .failure(_): break
            }
        }
    }
    
    func checkVisitsById(placeID: String) {
        NetworkingHelper.shared.fetchData(urlRequest: .checkVisitByPlaceId(placeId: placeID)) { [weak self](result: Result<GenericResponseModel, Error>) in
            switch result {
                case .success(let success):
                    self?.checking?(success.status!)
                case .failure(let failure):
                    self?.errorMessage!(failure.localizedDescription)
            }
        }
    }
    
    func checkForUser() {
        NetworkingHelper.shared.fetchData(urlRequest: .getAllPlacesForUser) {[weak self](result: Result<GetAllPlacesForUserResponse, Error>)in
            switch result {
                case .success(let success):
                    self?.userCheck?((success.data?.places)!)
                case .failure(_): break
            }
        }
    }
    
    func deletePlace(placeId: String) {
        NetworkingHelper.shared.fetchData(urlRequest: .deletePlace(placeId: placeId)) {[weak self](result: Result<GenericResponseModel, Error>)in
            switch result {
                case .success(let success):
                    self?.successMessage?(success.message!, nil)
                case .failure(let failure):
                    self?.errorMessage!(failure.localizedDescription)
            }
        }
    }
}
