import AVFoundation
import CoreLocation
import Photos
import UIKit

class PrivacyManager: NSObject, CLLocationManagerDelegate {
    static let shared = PrivacyManager()
    static let permissionStatusChangedNotification = Notification.Name("PermissionStatusChanged")
    
    enum PrivacyType: String {
        case camera = "Camera"
        case photoLibrary = "PhotoLibrary"
        case location = "Location"
    }
    
    func switchTagToPrivacyType(_ tag: Int) -> PrivacyType? {
        switch tag {
            case 0:
                return .camera
            case 1:
                return .photoLibrary
            case 2:
                return .location
            default:
                return nil
        }
    }
    
    
    // MARK: - Update Permission
    
    func updatePermission(for privacyType: PrivacyType, isEnabled: Bool) {
        switch privacyType {
            case .camera,.location,.photoLibrary:
                requestPermission(for: .camera, completion: { granted in
                    NotificationCenter.default.post(name: PrivacyManager.permissionStatusChangedNotification, object: nil)
                })
        }
    }
    
    // MARK: - Open App Settings
    
    func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { _ in
            }
        }
    }
    
    // MARK: - Request and Check Permission
    
    func requestPermission(for privacyType: PrivacyType, completion: @escaping (Bool) -> Void) {
        switch privacyType {
            case .camera:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        completion(granted)
                    }
                }
            case .photoLibrary:
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        completion(status == .authorized)
                    }
                }
            case .location:
                let locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func isPermissionGranted(for privacyType: PrivacyType) -> Bool {
        switch privacyType {
            case .camera:
                return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
            case .photoLibrary:
                return PHPhotoLibrary.authorizationStatus() == .authorized
            case .location:
                return CLLocationManager().authorizationStatus == .authorizedWhenInUse
        }
    }
    
}
