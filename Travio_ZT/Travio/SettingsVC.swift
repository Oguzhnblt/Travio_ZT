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
    
    private lazy var labelMainView : UIView = {
        let main = UIView()
        main.backgroundColor = UIColor(named: "textFieldBackgroundColor")
        main.layer.cornerRadius = 16
        return main
        }()
    private lazy var labelStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        
        return stack
    }()
    private lazy var labelIcon : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "user_alt")
        img.contentMode = .scaleAspectFit
        
        
        return img
    }()
   
    
    
    
    private lazy var labelText : UILabel = {
        let label = UILabel()
        label.text = "Security Settings"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var btnPower:UIButton = {
            let b = UIButton()

            b.addTarget(self, action: #selector(btnPowerTapped), for: .touchUpInside)
            b.contentHorizontalAlignment = .center
            b.layer.cornerRadius = 8
            b.centerTextAndImage(spacing: 8)
            b.setImage(UIImage(named: "power"), for: .normal)
            b.tintColor = .white
            return b
        }()
    @objc func btnPowerTapped(){
      }
    
    private lazy var labelButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(btnLabelTapped), for: .touchUpInside)
        b.setImage(UIImage(named: "vector"), for: .normal)
        return b
        
    }()
    @objc func btnLabelTapped(){
      }
    
    
    
    
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
        self.view.addSubviews(settingsView, settingsItemView, settingsText, btnPower)
        settingsItemView.addSubviews(settingsItemStackView, labelMainView,settingsImageView, imageText, editProfileText)
        labelMainView.addSubviews(labelStack)
        labelStack.addArrangedSubviews(labelIcon, labelText, labelButton)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        labelIcon.snp.makeConstraints({icon in
            icon.leading.equalTo(labelStack.snp.leading).offset(16)
            icon.size.equalTo(20)
            icon.right.equalTo(labelText.snp.left).offset(-8)
        
        })
        labelButton.snp.makeConstraints({btn in
            btn.trailing.equalTo(labelStack.snp.trailing).offset(-16)
        })
        
        
        btnPower.snp.makeConstraints({btn in
            btn.bottom.equalTo(settingsItemView.snp.top).offset(-61)
            btn.trailing.equalToSuperview().offset(-24)
        })
        
    
        
        labelMainView.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
                        make.width.equalTo(358)
                        make.height.equalTo(54)
        })
        
        labelStack.snp.makeConstraints({ stack in
            stack.top.equalToSuperview().offset(17)
            stack.bottom.equalToSuperview().offset(-15)
            stack.leading.equalToSuperview().offset(16.5)
            stack.trailing.equalToSuperview().offset(-16.5)
            
        })
        
        imageText.snp.makeConstraints({text in
            text.top.equalTo(settingsImageView.snp.bottom).offset(8)
            text.leading.equalToSuperview().offset(150)
        })
        
        editProfileText.snp.makeConstraints({text in
            text.leading.equalTo(settingsView).offset(164)
            text.top.equalTo(imageText.snp.bottom).offset(8)
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
