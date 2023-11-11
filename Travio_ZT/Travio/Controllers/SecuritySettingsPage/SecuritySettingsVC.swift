//
//  SecuritySettingsVC.swift
//  Travio
//
//  Created by Oğuz on 1.11.2023.
//

import UIKit
import SnapKit

class SecuritySettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
  
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .black
        headerLabel.text = "Security Settings"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        return headerLabel
    }()
    
    private lazy var securityItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
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
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    private let sections = ["Change Password", "Privacy"]
    private let passwordItems = ["New Password", "New Password Confirm"]
    private let privacyItems = ["Camera", "Photo Library", "Location"]
    
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
        view.backgroundColor = UIColor.background
        view.addSubviews(securityItemView, backButton, headerLabel)
        securityItemView.addSubviews(tableView, saveButton)
        
        securityItemView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(135)
            make.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-5)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(24)
            make.top.equalToSuperview().offset(80)
        }
        
        tableView.dropShadow()
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(saveButton.snp.top).offset(-16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-55)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? passwordItems.count : privacyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = ChangePasswordCell()
            cell.label.text = passwordItems[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        } else {
            let cell = PrivacyCell()
            cell.label.text = privacyItems[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.toggleSwitch.isOn = false
            return cell
        }
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
    static var previews: some View{
        
        SecuritySettingsVC().showPreview()
    }
}
#endif

