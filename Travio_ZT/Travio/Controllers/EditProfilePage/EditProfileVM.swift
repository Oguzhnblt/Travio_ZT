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
    var showAlertVM: ((String) -> Void)?
    
    func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
    
    func validateInputs(fullName: String, email: String) -> (isValid: Bool, errorMessage: String) {
           if fullName.isEmpty {
               return (false, "Full Name alanı boş bırakılamaz.")
           }

           if !isValidEmail(email) {
               return (false, "Geçersiz Email.")
           }

           return (true, "")
       }

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

    func changeMyProfile(profile: EditProfileRequest) {
            let params = ["full_name": profile.full_name, "email": profile.email, "pp_url": profile.pp_url]

            NetworkingHelper.shared.fetchData(urlRequest: .editProfile(params: params as Parameters)) { [weak self] (result: Result<EditProfileResponse, Error>) in
                switch result {
                case .success(_):
                    let successMessage = "Profil başarıyla güncellendi."
                    self?.showAlertVM?(successMessage)
                case .failure(_):
                    let customMessage = "Profil güncellenemedi."
                    self?.showAlertVM?(customMessage)
                }
            }
        }
        public func uploadImage(images: [UIImage]) {
            let urlRequest = Router.upload(params: ["file": images])

            NetworkingHelper.shared.imageToURLs(images: images, urlRequest: urlRequest, callback: { [weak self] (result: Result<UploadResponse, Error>) in
                switch result {
                case .success(let success):
                    self?.transferURLs?(success.urls)
                case .failure(_):
                    let customMessage = "URL alınamadı."
                    self?.showAlertVM?(customMessage)
                }
            })
        }
    
}
