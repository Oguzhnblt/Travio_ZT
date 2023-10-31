//
//
//  SettingsVC.swift
//  Travio
//
//  Created by web3406 on 27.10.2023.
//
//
import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    private lazy var settingsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    private lazy var settingsItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private lazy var profileImage : UIImageView = {
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "image_profile")
        return profileImage
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "img_logout"), for: .normal)
        button.addTarget(self, action: #selector(buttonLogoutTapped), for: .touchUpInside)
        button.sizeThatFits(CGSize(width: 30, height: 30))
        
        return button
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.addTarget(self, action: #selector(buttonEditProfileTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonEditProfileTapped() {
        
    }
    
    @objc func buttonLogoutTapped(){
    }
    
    private func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.textAlignment = alignment
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var settingsText = createLabel(text: "Settings", color: "textFieldBackgroundColor", textSize: 32, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var profileText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 16, fontName: "Poppins-SemiBold", alignment: .center)
    
    private lazy var editProfileText = createLabel(text: "Edit Profile", color: "backgroundColor", textSize: 12, fontName: "Poppins-SemiBold", alignment: .center)
    
//    private lazy var securitySettings = CustomView(icon: .userAlt, labelText: "Security Settings")
//    private lazy var appDefaults = CustomView(icon: .appDefaults, labelText: "App Defaults")
//    private lazy var myAddedPlaces = CustomView(icon: .mapPinIcon, labelText: "My Added Places")
//    private lazy var helpSupport = CustomView(icon: .helpIcon, labelText: "Help & Support")
//    private lazy var about = CustomView(icon: .aboutInfoIcon, labelText: "About")
//    private lazy var terms = CustomView(icon: .termsIcon, labelText: "Terms of Use")
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    
    func setupViews() {
        self.view.addSubviews(settingsView, settingsItemView, settingsText, logoutButton)
        settingsItemView.addSubviews(profileImage, profileText, editProfileButton)
    
        setupLayout()
    }
    
    func setupLayout() {
        
        settingsView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        
        settingsItemView.snp.makeConstraints({make in
            make.edges.equalToSuperview().offset(175)
            make.left.right.equalToSuperview()
        })
        
        settingsText.snp.makeConstraints({make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(95)
        })
        
        logoutButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(95)
        })
        
        profileImage.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        })
        
        profileText.snp.makeConstraints({make in
            make.top.equalTo(profileImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        })
        
        editProfileButton.snp.makeConstraints({make in
            make.top.equalTo(profileText.snp.bottom)
            make.centerX.equalToSuperview()
        })
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SettingsVC_Preview: PreviewProvider {
    static var previews: some View{
        
        SettingsVC().showPreview()
    }
}
#endif
