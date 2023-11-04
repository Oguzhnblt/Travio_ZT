import UIKit
import SnapKit

class HelpSupportVC: UIViewController {
    
    var textView: UIView!
    var toggleButton: UIButton!
    
    var isExpanded = false
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = "Security Settings"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()
    
    private func fieldLabel(title: String) -> UILabel{
        let fieldLabel = UILabel()
        fieldLabel.textColor = .background
        fieldLabel.text = title
        fieldLabel.font = UIFont(name: "Poppins-SemiBold", size: 16)
        
        return fieldLabel
    }
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var saveButton: UIButton = {
        
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.size(CGSize(width: 342, height: 54))
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = .background
        return saveButton
    }()
    
    private lazy var securityItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private lazy var newPassword: HelpSupportCell = {
        let tf = HelpSupportCell()
        tf.
        return tf
    }()
    
    private lazy var newPasswordConfirm: HelpSupportCell = {
        let tf = HelpSupportCell()
        return tf
    }()
  
    
    private func stackView() -> UIStackView  {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        
        return stack
    }
    
    private lazy var passwordStack = stackView()
    private lazy var privacyStack = stackView()
    
    private lazy var changePasswordLabel = fieldLabel(title: "Change Password")
    private lazy var privacyLabel = fieldLabel(title: "Privacy")
    
  
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped() {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .background
        self.view.addSubviews(securityItemView,backButton, headerLabel)
        
        passwordStack.addArrangedSubviews(newPassword,newPasswordConfirm)
        
        securityItemView.addSubviews(saveButton, passwordStack, changePasswordLabel)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        securityItemView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(125)
            make.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
            make.left.equalToSuperview().offset(24)
        })
        
        headerLabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        })
        
        
        passwordStack.dropShadow()
        passwordStack.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(55)
            make.left.right.equalToSuperview().inset(24)
        })
    
        saveButton.snp.makeConstraints({ make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(securityItemView.snp.top).offset(647)
            make.left.right.equalToSuperview().inset(24)
        })
        
        changePasswordLabel.snp.makeConstraints({make in
            make.bottom.equalTo(passwordStack.snp.top)
            make.left.equalToSuperview().offset(36)
        })
       
    }}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HelpSupportVC_Preview: PreviewProvider {
    static var previews: some View {
        HelpSupportVC().showPreview()
    }
}
#endif
