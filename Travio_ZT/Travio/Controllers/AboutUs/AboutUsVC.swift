//
//  AboutUsVC.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class AboutUsVC: UIViewController {
    
    private var termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setupView(
            title: "About Us",
            buttonImage: UIImage(named: "leftArrowIcon"),
            buttonPosition: .left,
            headerLabelPosition: .center,
            buttonAction: #selector(buttonTapped),
            itemsView: [termsTextView]
        )
        
        setupLayouts()
        
    }
    
    private func setupLayouts() {
        
        termsTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }

    }
    private func fetchTermsData() {
        AF.request("https://api.iosclass.live/about").responseString {[weak self] response in
            switch response.result {
            case .success(let data):
                if let attributedString = self?.attributedString(from: data) {
                    self?.termsTextView.attributedText = attributedString
                } else {
                    self?.termsTextView.text = data
                }
            case .failure(let error):
                print("Veri çekme hatası: \(error)")
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

@available(iOS 13 , *)
struct AboutUsVC_Preview: PreviewProvider {
    static var previews: some View {
        AboutUsVC().showPreview()
    }
}
#endif

