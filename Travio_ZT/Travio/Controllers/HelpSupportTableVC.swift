//
//  HelpSupportTableVC.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import UIKit
import SnapKit


enum CellState {
    case collapsed
    case expanded
}

class HelpSupportTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var cellStates: [IndexPath: CellState] = [:]
    private var selectedIndexPath: IndexPath?
    private var isExpanded: Bool = false

    private lazy var expandedHeight: CGFloat = 155
    private lazy var collapsedHeight: CGFloat = 60

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HelpSupportTableCell.self, forCellReuseIdentifier: HelpSupportTableCell.cellReuseIdentifier)
        tableView.backgroundColor = UIColor.content
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = .white
        headerLabel.text = "Help&Support"
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 32)
        return headerLabel
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var contentLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor(named: "backgroundColor")
        headerLabel.text = "FAQ"
        headerLabel.font = UIFont(name: "Poppins-SemiBold", size: 24)
        return headerLabel
    }()

    private lazy var helpSuppportItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.content
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        self.view.addSubviews(backButton, headerLabel, helpSuppportItemView)
        helpSuppportItemView.addSubviews(contentLabel,tableView)

        backButton.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(headerLabel.snp.left)
            make.left.equalToSuperview()
        })

        headerLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(72)
        })

        helpSuppportItemView.snp.makeConstraints({ make in
            make.top.equalTo(headerLabel.snp.bottom).offset(58)
            make.left.right.bottom.equalToSuperview()
        })
        contentLabel.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(16)
        })

        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(90)
            make.left.right.equalToSuperview().inset(8)
        }
      
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpSupportTableCell.cellReuseIdentifier, for: indexPath) as! HelpSupportTableCell

        let item = helpItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.subtitle
        
        cell.backgroundColor = UIColor.content
        cell.selectionStyle = .none

        let cellState = cellStates[indexPath]
        cell.iconImageView.image = cellState == .expanded ? UIImage.imgArrow : UIImage.imgRightArrow

        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let cellState = cellStates[indexPath]
            return cellState == .expanded ? expandedHeight : collapsedHeight
        }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellState = cellStates[indexPath] {
            cellStates[indexPath] = cellState == .collapsed ? .expanded : .collapsed
        } else {
            cellStates[indexPath] = .expanded
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
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
