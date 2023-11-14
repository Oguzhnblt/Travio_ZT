//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class SecuritySettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private lazy var viewModel = SecuritySettingsVM()
    
      private let sections = ["Privacy"]
      private let passwordItems = ["New Password", "New Password Confirm"]
      private let privacyItems = ["Camera", "Photo Library", "Location"]
      
    
    private lazy var newPasswordField = CommonTextField(labelText: "New Password", textFieldPlaceholder: "******", isSecure: true)
    private lazy var newPasswordConfirmField = CommonTextField(labelText: "New Password Confirm", textFieldPlaceholder: "******", isSecure: true)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newPasswordField, newPasswordConfirmField])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var fieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Change Password"
        label.font = UIFont(name: "Poppins-Semibold", size: 16)
        label.textColor = UIColor(named: "backgroundColor")
        return label
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
  
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 12
        saveButton.clipsToBounds = true
        saveButton.backgroundColor = UIColor(named: "backgroundColor")
        return saveButton
    }()
    

    @objc func saveButtonTapped() {
        let validation = viewModel.validatePasswordFields(newPassword: newPasswordField.textField.text, confirmPassword: newPasswordConfirmField.textField.text)

        switch validation {
        case .success:
            guard let new_password = newPasswordField.textField.text else {
                return
            }
            viewModel.changePassword(profile: ChangePasswordRequest(new_password: new_password)) { result in
                switch result {
                case .success(let successMessage):
                    self.showAlert(message: successMessage)

                case .failure(let error):
                    self.showAlert(message: error.localizedDescription)
                }
            }
        case .failure(let errorMessage):
            showAlert(message: errorMessage)
        }
    }


    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
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
        setupView(title: "Security Settings",buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [fieldLabel, stackView, tableView, saveButton])
        
        fieldLabel.snp.makeConstraints({make in
            make.bottom.equalTo(stackView.snp.top)
            make.left.equalTo(stackView.snp.left).offset(12)
            
        })

        stackView.dropShadow()
        stackView.snp.makeConstraints({make in
            make.bottom.equalTo(tableView.snp.top)
            make.left.right.equalToSuperview().inset(16)
        })
        
        tableView.dropShadow()
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        saveButton.snp.makeConstraints({make in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.width.equalTo(342)
            make.height.equalTo(54)
            make.left.right.equalToSuperview().inset(16)
            
        })
    }
 
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privacyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = PrivacyCell()
            cell.label.text = privacyItems[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.toggleSwitch.isOn = false
            return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(named: "backgroundColor")
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 16)
        titleLabel.text = sections[section]
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct SecuritySettingsVC_Preview: PreviewProvider {
    static var previews: some View {
        SecuritySettingsVC().showPreview().ignoresSafeArea()
    }
}
#endif

