//
//  PermissionManager.swift
//  Travio
//
//  Created by Oğuz on 20.11.2023.
//

import AVFoundation
import UIKit

class PermissionManager {
    static let shared = PermissionManager()

    private init() {}

    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }

    func showCameraPermissionAlert(on viewController: UIViewController, deniedAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: "Kamera İzni Reddedildi",
            message: "Kamera izni reddedildi. Ayarlara giderek izni açabilirsiniz.",
            preferredStyle: .alert
        )

        let settingsAction = UIAlertAction(title: "Ayarlar", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }

        let cancelAction = UIAlertAction(title: "İptal", style: .cancel) { _ in
            deniedAction?()
        }

        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
