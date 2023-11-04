import UIKit
import SnapKit

class HelpSupportVC: UIViewController {
    
    var textView: UIView!
    var toggleButton: UIButton!
    
    var isExpanded = false
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = "Help&Support"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        
        return headerLabel
    }()
    
    private func fieldLabel(title: String) -> UILabel{
        let fieldLabel = UILabel()
        fieldLabel.textColor = .background
        fieldLabel.text = title
        fieldLabel.font = UIFont(name: "Poppins-SemiBold", size: 24)
        
        return fieldLabel
    }
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
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
        tf.label.text = "New Password"
        tf.subtitleLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
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
    
    private lazy var changePasswordLabel = fieldLabel(title: "FAQ")
    
  
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .background
        self.view.addSubviews(securityItemView,backButton, headerLabel)
        
        passwordStack.addArrangedSubviews(newPassword)
        
        securityItemView.addSubviews(passwordStack, changePasswordLabel)
        
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
