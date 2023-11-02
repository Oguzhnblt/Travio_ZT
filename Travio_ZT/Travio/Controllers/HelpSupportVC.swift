//
//  HelpSupportVC.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.
//

import UIKit
import SnapKit

class HelpSupportVC: UIViewController {
    
    var stackView: UIStackView!
    var textView: UITextView!
    var toggleButton: UIButton!

    var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        view.addSubview(stackView)

        textView = UITextView()
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 16

        toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Toggle", for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubviews(textView,toggleButton)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        textView.snp.makeConstraints { make in
            make.height.equalTo(50) // Initial height
        }

        toggleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16) // Align to the right
        }
    }

    @objc func toggleButtonTapped() {
        isExpanded.toggle()

        let newHeight: CGFloat = isExpanded ? 200 : 50
        UIView.animate(withDuration: 0.5, animations: {
            self.textView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }
            self.view.layoutIfNeeded()
        })
    }

}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HelpSupportVC_Preview: PreviewProvider {
    static var previews: some View{
        
        HelpSupportVC().showPreview()
    }
}
#endif


