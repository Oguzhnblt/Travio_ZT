//
//  ActivityIndicator.swift
//  Travio
//
//  Created by Oğuz on 24.11.2023.
//

import UIKit
import SnapKit

class ActivityIndicatorManager {
    private var blurEffectView: UIVisualEffectView?
    private var indicator: UIActivityIndicatorView?
    private var label: UILabel?

    func showIndicator(in view: UIView, text: String? = nil) {
        showBlurEffect(in: view)

        indicator = createActivityIndicator()
        view.addSubview(indicator!)
        indicator?.startAnimating()

        if let text = text {
            label = createLabel(with: text)
            indicator?.addSubview(label!)
        }
    }

    func hideIndicator() {
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()

        label?.removeFromSuperview()

        if let blurEffectView = blurEffectView {
            blurEffectView.removeFromSuperview()
        }
    }

    private func showBlurEffect(in view: UIView) {
        let blurEffect = UIBlurEffect(style: .prominent)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        indicator.center = blurEffectView!.center
        return indicator
    }

    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .background
        label.textAlignment = .center
        label.font = AppTheme.getFont(name: .medium, size: .size14)
        
        indicator?.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(indicator!.snp.bottom).offset(8)
        }
        
        return label
    }

}
