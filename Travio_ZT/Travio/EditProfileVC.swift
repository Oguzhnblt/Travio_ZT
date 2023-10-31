//
//  EditProfileVC.swift
//  Travio
//
//  Created by web3406 on 31.10.2023.
//
import UIKit
import SnapKit

class EditProfileVC: UIViewController {
    private func addTextField(title: String, placeholder: String, keyboardType: UIKeyboardType, isSecure: Bool) -> CustomLabelTextField {
           let textField = CustomLabelTextField()
           textField.font = UIFont(name: "Poppins-Regular", size: 12)
           textField.backgroundColor = UIColor(named: "textFieldBackgroundColor")
           textField.layer.cornerRadius = 16
           textField.placeholder = placeholder
           textField.customLabel.text = title
           textField.isSecureTextEntry = isSecure
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
    
    
    private lazy var editProfileText = createLabel(text: "Edit Profile", color: "textFieldBackgroundColor", textSize: 32, fontName: "Poppins-SemiBold", alignment: .center)
    
    
    private lazy var imageText = createLabel(text: "Bruce Wills", color: "textColor", textSize: 24, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var changePhotoText = createLabel(text: "Change Photo", color: "backgroundColor", textSize: 12, fontName: "Poppins-SemiBold", alignment: .center)
    private lazy var editProfileImageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "image_3")
        return img
        }()

    

    private lazy var editProfileView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "backgroundColor")
            return view
        }()
        
        private lazy var editProfileItemView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "contentColor")
            view.clipsToBounds = true
            view.layer.cornerRadius = 80
            view.layer.maskedCorners = .layerMinXMinYCorner
            return view
        }()
    
    private lazy var saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Save", for: .normal)
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 12
            button.layer.backgroundColor = UIColor(named: "backgroundColor")?.cgColor
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            return button
        }()
    
    @objc func saveButtonTapped(){}
    
    private lazy var btnX:UIButton = {
            let b = UIButton()

            b.addTarget(self, action: #selector(btnXTapped), for: .touchUpInside)
            b.contentHorizontalAlignment = .center
            b.layer.cornerRadius = 8
            b.centerTextAndImage(spacing: 8)
            b.setImage(UIImage(named: "x_image"), for: .normal)
            b.tintColor = .white
            return b
        }()
    @objc func btnXTapped(){
      }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        
    }
    private lazy var fullnameTextField = addTextField(title: "Full Name", placeholder: "bilge_adam", keyboardType: .default, isSecure: false)
    private lazy var emailTextField = addTextField(title: "Email", placeholder: "bilge_adam", keyboardType: .emailAddress, isSecure: false)
    
    
    private func setupViews(){
        self.view.addSubviews(editProfileView, editProfileItemView, editProfileText, btnX)
        editProfileItemView.addSubviews(saveButton, fullnameTextField, emailTextField, editProfileImageView, imageText, changePhotoText)
        setupLayout()
    }
   
    private func setupLayout(){
        
        editProfileImageView.snp.makeConstraints({img in
            img.width.equalTo(120)
            img.height.equalTo(120)
            img.top.equalTo(editProfileItemView.snp.top).offset(24)
            img.leading.equalToSuperview().offset(135)
            
        })
        
        imageText.snp.makeConstraints({txt in
            txt.top.equalTo(changePhotoText.snp.bottom).offset(7)
            txt.leading.equalToSuperview().offset(128)
        })
        
        changePhotoText.snp.makeConstraints({txt in
            txt.top.equalTo(editProfileImageView.snp.bottom).offset(7)
            txt.leading.equalToSuperview().offset(152)
        })
        
        
        btnX.snp.makeConstraints({btn in
            btn.bottom.equalTo(editProfileItemView.snp.top).offset(-81)
            btn.trailing.equalToSuperview().offset(-24)
        })
        
        editProfileText.snp.makeConstraints({text in
            text.bottom.equalTo(editProfileItemView.snp.top).offset(-67)
            text.leading.equalToSuperview().offset(24)
        })

        editProfileView.snp.makeConstraints({editView in
                    editView.edges.equalToSuperview()
                    editView.top.equalTo(self.view.safeAreaLayoutGuide)
                })
        editProfileItemView.snp.makeConstraints({itemView in
                    itemView.top.bottom.equalTo(editProfileView).offset(164)
                    itemView.left.right.equalTo(editProfileView)
                })
        saveButton.snp.makeConstraints({btn in
            btn.height.equalTo(51)
            btn.width.equalTo(342)
            btn.left.equalTo(editProfileItemView).offset(24)
            btn.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-18)
        })
        
        fullnameTextField.snp.makeConstraints({name in
            name.height.equalTo(74)
            name.width.equalTo(342)
            name.leading.equalToSuperview().offset(24)
            name.trailing.equalToSuperview().offset(-24)
            name.top.equalTo(editProfileItemView.snp.top).offset(304)
            
        })
        
        emailTextField.snp.makeConstraints({mail in
            mail.height.equalTo(74)
            mail.width.equalTo(342)
            mail.leading.equalToSuperview().offset(24)
            mail.trailing.equalToSuperview().offset(-24)
            mail.top.equalTo(fullnameTextField.snp.bottom).offset(16)
            
        })
        
        
        
        
        
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct EditProfileVC_Preview: PreviewProvider {
    static var previews: some View{
         
        EditProfileVC().showPreview()
    }
}
#endif
