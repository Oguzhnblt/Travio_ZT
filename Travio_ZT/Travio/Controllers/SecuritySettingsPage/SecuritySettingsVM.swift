//
//  SecuritySettingsVM.swift
//  Travio
//
//  Created by web3406 on 13.11.2023.
//

import Foundation
import Alamofire

class SecuritySettingsVM {
    func changePassword(profile: ChangePasswordRequest) {
        var showAlertFailure: ((String) -> Void)?

        
        let params = ["new_password": profile.new_password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .changePassword(params: params as Parameters)) {(result: Result<ChangePasswordResponse, Error>) in
            switch result {
                case .success(let success):
                    print(success.message!)
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
}
