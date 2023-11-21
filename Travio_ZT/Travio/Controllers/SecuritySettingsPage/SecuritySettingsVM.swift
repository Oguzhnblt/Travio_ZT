
import Foundation
import Alamofire
import AVFoundation



enum ValidationResult {
    case success
    case failure(String)
}

class SecuritySettingsVM {
    
    
    var successAlert: ((String) -> Void)?
    
    func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        }
    
    func validatePasswordFields(newPassword: String?, confirmPassword: String?) -> ValidationResult {
        guard let new_password = newPassword, !new_password.isEmpty,
              let new_password_confirm = confirmPassword, !new_password_confirm.isEmpty
        else {
            return .failure("Lütfen tüm alanları doldurun.")
        }
        
        if new_password.count >= 6 {
            if new_password == new_password_confirm {
                return .success
            } else {
                return .failure("Şifreler eşleşmiyor.")
            }
        } else {
            return .failure("Şifre en az 6 karakter içermelidir.")
        }
    }
    
    func changePassword(_ profile: ChangePasswordRequest) {
        let params = ["new_password": profile.new_password]
        
        NetworkingHelper.shared.fetchData(urlRequest: .changePassword(params: params as Parameters)) { (result: Result<GenericResponseModel, Error>) in
            switch result {
                case .success(_):
                    let message = "Şifreniz başarıyla değiştirildi."
                    self.successAlert?(message)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}
