//
//  TermsOfUseVC.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class TermsOfUseVC: UIViewController {

    private var termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.backgroundColor = UIColor(named: "contentColor")
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        setupViews()
        fetchTermsData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func setupViews() {
        view.addSubview(termsTextView)
        setupLayouts()
    }

    private func setupLayouts() {
        termsTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(96)
            make.leading.trailing.bottom.equalToSuperview()
        }
        setupView(
            title: "Terms of Use",
            buttonImage: UIImage(named: "leftArrowIcon"),
            buttonPosition: .left,
            headerLabelPosition: .center,
            buttonAction: #selector(buttonTapped),
            itemsView: [termsTextView]
        )
    }

    private func fetchTermsData() {
        AF.request("https://api.iosclass.live/terms").responseString { response in
            switch response.result {
            case .success(let data):
                if let attributedString = self.attributedString(from: data) {
                    self.termsTextView.attributedText = attributedString
                } else {
                    self.termsTextView.text = data
                }
            case .failure(let error):
                print("Şartlar verisi çekme hatası: \(error)")
            }
        }
    }

    private func attributedString(from htmlString: String) -> NSAttributedString? {
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]

            let attributedString = try NSAttributedString(data: Data(htmlString.utf8),
                                                          options: options,
                                                          documentAttributes: nil)
            return attributedString
        } catch {
            print("HTML'yi NSAttributedString'a dönüştürme hatası: \(error)")
            return nil
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TermsOfUseVC_Preview: PreviewProvider {
    static var previews: some View {
        TermsOfUseVC().showPreview().ignoresSafeArea()
    }
}
#endif

