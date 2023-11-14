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

    
    public func uploadImage(images: [UIImage]) {
        let urlRequest = Router.upload(params: ["file": images]) 
        
        NetworkingHelper.shared.imageToURLs(images: images, urlRequest: urlRequest, callback: { (result: Result<UploadResponse, Error>) in
            switch result {
            case .success(let success):
                self.transferURLs?(success.urls)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }

}
