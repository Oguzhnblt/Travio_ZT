//
//  HelpSupportTableVC.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import UIKit
import SnapKit

class HelpSupportTableVC: UIViewController {

    private var selectedIndexPath: IndexPath?


    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: HelpSupportTableCell.cellReuseIdentifier)
        tableView.backgroundColor = AppTheme.getColor(name: .content)
        tableView.separatorStyle = .none

        return tableView
    }()

    private lazy var contentLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = AppTheme.getColor(name: .background)
        headerLabel.text = "FAQ"
        headerLabel.font = AppTheme.getFont(name: .semibold, size: .size24)
        return headerLabel
    }()

 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    

    private func setupUI() {
        setupView(title: "Help&Support",buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [tableView, contentLabel])

        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(90)
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
      
        contentLabel.snp.makeConstraints({make in
            make.top.equalTo(tableView.snp.top).offset(-30)
            make.left.equalToSuperview().offset(16)
        })
    }
}

extension HelpSupportTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpSupportTableCell.cellReuseIdentifier, for: indexPath) as! HelpSupportTableCell
        
        cell.configure(helpItems[indexPath.row])

        
        cell.backgroundColor = AppTheme.getColor(name: .content)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension HelpSupportTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        helpItems[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}



#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct HelpSupportTableVC_Preview: PreviewProvider {
    static var previews: some View {
        HelpSupportTableVC().showPreview()
    }
}
#endif
