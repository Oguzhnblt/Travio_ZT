//
//  Alerts.swift
//  Travio
//
//  Created by Oğuz on 21.11.2023.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitle: String? = nil, cancelTitle: String? = nil, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        
        alertController.addAction(okAction)
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
