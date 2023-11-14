//
//  EditProfileVM.swift
//  Travio
//
//  Created by Oğuz on 12.11.2023.
//

import Foundation
import Alamofire
import UIKit

class EditProfileVM {
    
    var dataTransfer: ((ProfileResponse) -> Void)?
    var transferURLs: (([String]) -> Void)?
    
    func myProfile() {
        
        NetworkingHelper.shared.fetchData(urlRequest: .myProfile) { [weak self] (result: Result<ProfileResponse, Error>) in
            switch result {
                case .success(let profile):
                    self!.dataTransfer!(profile)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func changeMyProfile(profile: EditProfileRequest) {
        let params = ["full_name": profile.full_name, "email": profile.email, "pp_url": profile.pp_url]
        
        NetworkingHelper.shared.fetchData(urlRequest: .editProfile(params: params as Parameters)) {(result: Result<EditProfileResponse, Error>) in
            switch result {
                case .success(let success):
                    print(success.message!)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }

//    func uploadImage(data: [UIImage]) {
//        let params = ["file": data]
//        NetworkingHelper.shared.fetchData(urlRequest: .upload(params: params)) { [self] (result: Result<UploadResponse, Error>) in
//            switch result {
//            case .success(let success):
//                    self.transferURLs!(success.urls)
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//    }
    
    public func uploadImage(images: [UIImage]){
           
           let url = "https://ios-class-2f9672c5c549.herokuapp.com/upload"
           let headers = HTTPHeaders(["Content-Type": "multipart/form-data"])
           
           NetworkingHelper.shared.uploadImages(images: images, url: url, headers: headers, callback: {(result: Result<UploadResponse,Error>) in
               switch result {
               case .success(let success):
                       self.transferURLs?(success.urls)
               case .failure(let failure):
                       print(failure.localizedDescription)
               }
           })
       }

}
