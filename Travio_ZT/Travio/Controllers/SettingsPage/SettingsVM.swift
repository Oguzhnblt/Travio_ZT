//
//  SettingsVM.swift
//  Travio
//
//  Created by web3406 on 15.11.2023.
//
import Foundation

class SettingsVM {
    
    var dataTransfer: ((ProfileResponse) -> Void)?
    var showAlertVM: ((String) -> Void)?
    
    func myProfile() {
        NetworkingHelper.shared.fetchData(urlRequest: .myProfile) { [weak self] (result: Result<ProfileResponse, Error>) in
            switch result {
            case .success(let profile):
                self?.dataTransfer?(profile)
            case .failure(let err):
                let customMessage = err.localizedDescription
                self?.showAlertVM?(customMessage )
            }
        }
    }
}
