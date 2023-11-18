
import Foundation
import Alamofire



enum ValidationResult {
    case success
    case failure(String)
}

class SecuritySettingsVM {
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
        
        NetworkingHelper.shared.fetchData(urlRequest: .changePassword(params: params as Parameters)) { (result: Result<ChangePasswordResponse, Error>) in
            switch result {
                case .success(let success):
                    print(success.message!)
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
    
}
