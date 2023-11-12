//
//  EditProfileVM.swift
//  Travio
//
//  Created by Oğuz on 12.11.2023.
//

import Foundation
import Alamofire

class EditProfileVM {
    
    var dataTransfer: ((ProfileResponse) -> Void)?
    
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
        
        NetworkingHelper.shared.fetchData(urlRequest: .editProfile(params: params)) {(result: Result<EditProfileResponse, Error>) in
            switch result {
                case .success(let success):
                    print(success.message!)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
