//
//  EditProfileVM.swift
//  Travio
//
//  Created by Oğuz on 12.11.2023.
//

import Foundation
import Alamofire

class EditProfileVM {
    
    var showAlertFailure: ((String) -> Void)?
    var navigateToViewController: (() -> Void)?
    var loginSuccessCallback: ((String) -> Void)?


    func myProfile() {
               
        NetworkingHelper.shared.fetchData(urlRequest: .myProfile) { [weak self] (result: Result<ProfileResponse, Error>) in
            switch result {
                case .success(_):
//                    self?.loginSuccessCallback?(loginResponse.access_token!)
                    self?.navigateToViewController?()
                case .failure(_):
                    self?.showAlertFailure!("Erişim yetkiniz yok")
            }
        }
    }
}

