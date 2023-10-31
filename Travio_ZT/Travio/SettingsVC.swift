//
//  
//  SettingsVC.swift
//  Travio
//
//  Created by web3406 on 27.10.2023.
//
//
import UIKit
import TinyConstraints

class SettingsVC: UIViewController {
    
    private func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = .fillProportionally
        stackView.spacing = spacing
        stackView.alignment = .center
        return stackView
    }
    
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
    
    private lazy var settingsImageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "image_3")
        return img
        
        
    }()
    
    private func addTextField(title: String, placeholder: String, keyboardType: UIKeyboardType, isSecure: Bool) -> CustomLabelTextField {
        let textField = CustomLabelTextField()
        textField.font = UIFont(name: "Poppins-Regular", size: 12)
        textField.backgroundColor = UIColor(named: "textFieldBackgroundColor")
        textField.layer.cornerRadius = 16
        textField.placeholder = placeholder
        textField.customLabel.text = title
        textField.isSecureTextEntry = isSecure
        textField.autocapitalizationType = .none
        return textField
    }
    
    private func createLabel(text: String, color: String, textSize: CGFloat, fontName: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: color)
        label.numberOfLines = 1
        label.textAlignment = alignment
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    
    private lazy var settingsItemStackView = createStackView(axis: .vertical, spacing: 8)
    private lazy var settingsImageTextStackView = createStackView(axis: .vertical, spacing: 8)
    private lazy var settingsText = createLabel(text: "Settings", color: "textFieldBackgroundColor", textSize: 32, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var imageText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 16, fontName: "Poppins-SemiBold", alignment: .center)
    
    private lazy var editProfileText = createLabel(text: "Edit Profile", color: "backgroundColor", textSize: 12, fontName: "Poppins-SemiBold", alignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupViews()
       
    }
    
    //MARK: -- Component Actions
    
    
    //MARK: -- Private Methods
    
    
    //MARK: -- UI Methods
    func setupViews() {
        self.view.addSubviews(settingsView, settingsItemView, settingsText)
        settingsItemView.addSubviews(settingsItemStackView, settingsImageTextStackView)
        settingsImageTextStackView.addArrangedSubviews(settingsImageView, imageText, editProfileText)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        imageText.snp.makeConstraints({text in
            text.left.right.equalTo(settingsView).offset(150)
        })
        
        editProfileText.snp.makeConstraints({text in
            text.left.right.equalTo(settingsView).offset(164)
        })
        
        settingsImageView.snp.makeConstraints({image in
            image.width.equalTo(120)
            image.height.equalTo(120)
            image.top.equalTo(settingsItemView.snp.top).offset(24)
            image.leading.equalToSuperview().offset(135)
        })
        settingsView.snp.makeConstraints({settingView in
            settingView.edges.equalToSuperview()
            settingView.top.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        settingsText.snp.makeConstraints({text in
            text.bottom.equalTo(settingsItemView.snp.top).offset(-53)
            text.leading.equalToSuperview().offset(20)
        })
        
        settingsItemView.snp.makeConstraints({itemView in
            itemView.top.bottom.equalTo(settingsView).offset(164)
            itemView.left.right.equalTo(settingsView)
        })
        
        
        settingsItemStackView.snp.makeConstraints({stack in
            stack.left.right.equalTo(settingsItemView).inset(16)
            stack.top.equalTo(settingsItemView.snp.top).offset(218)

        })
        
        settingsImageTextStackView.snp.makeConstraints({stack in
            stack.left.right.equalTo(settingsItemView).inset(135)
            stack.top.equalTo(settingsItemView.snp.top).offset(24)
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
