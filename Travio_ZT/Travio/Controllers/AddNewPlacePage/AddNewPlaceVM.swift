//
//  AddNewPlaceVM.swift
//  Travio
//
//  Created by Oğuz on 15.11.2023.
//

import Foundation
import UIKit


class AddNewPlaceVM {
    var transferURLs: (([String]) -> Void)?
    var transferPlaceID: ((String) -> Void)?
    var showAlertVM: ((String) -> Void)?
    
    
    func addPlace(params: [String: Any]) {
        NetworkingHelper.shared.fetchData(urlRequest: .postPlace(params: params)) {(result: Result<GenericResponseModel, Error>) in
            switch result {
                case .success(let success):
                    self.transferPlaceID?(success.message!)
                    if success.status == "fail" {
                        let message = "Yer eklenirken bir hata oluştu. Lütfen tekrar deneyiniz."
                        self.showAlertVM?(message)
                    }
                case .failure(_): break
            }
        }
    }
    
    func uploadImage(images: [UIImage]) {
        let urlRequest = Router.upload(params: ["file": images])
        
        NetworkingHelper.shared.imageToURLs(images: images, urlRequest: urlRequest, callback: { [weak self] (result: Result<UploadResponse, Error>) in
            switch result {
                case .success(let success):
                    self?.transferURLs?(success.urls)
                case .failure(_): break
            }
        })
    }
    
    func postGalleryImage(params: [String: Any]) {
        NetworkingHelper.shared.fetchData(urlRequest: .postGalleryImage(params: params), completion: {(result: Result<GenericResponseModel, Error>) in
            switch result {
                case .success(_): break
                case .failure(_): break
            }
        })
    }
}
