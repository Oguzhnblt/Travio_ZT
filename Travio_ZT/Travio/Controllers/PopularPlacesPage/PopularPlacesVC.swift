//
//  PopularPlacesVC.swift
//  Travio
//
//  Created by Oğuz on 30.10.2023.
//

import UIKit
import SnapKit

class PopularPlacesVC: UIViewController {

    let viewModel = PopularPlacesVM()
    var popularPlaces = [Place]()

    private var isSorted = false
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "contentColor")
        tableView.register(PopularPlacesTableViewCell.self, forCellReuseIdentifier: "popularCell")
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    private lazy var sortButton: UIButton = {
        let sort = UIButton(type: .custom)
        sort.setImage(UIImage(named: "img_down_sort"), for: .normal)
        sort.addTarget(self, action: #selector(sortDown), for: .touchUpInside)

        return sort
    }()

    // MARK: Sorting

    @objc func sortDown() {
        isSorted.toggle()

        let imageName = isSorted ? "img_up_sort" : "img_down_sort"
        sortButton.setImage(UIImage(named: imageName), for: .normal)

        if isSorted {
            popularPlaces.sort { $0.title!.localizedCompare($1.title!) == .orderedAscending }
        } else {
            popularPlaces.sort { $0.title!.localizedCompare($1.title!) == .orderedDescending }
        }

        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
        popularPlacesData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func popularPlacesData() {
        viewModel.dataTransfer = { [weak self] place in
            self?.popularPlaces = place
            self?.tableView.reloadData()
        }
        viewModel.popularPlaces()
    }

    private func setupViews() {
        setupView(title: "Popular Places", buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [tableView, sortButton])

        setupLayouts()
    }

    private func setupLayouts() {
        tableView.snp.makeConstraints({ make in
            make.top.bottom.equalToSuperview().offset(35)
            make.left.right.equalToSuperview().inset(16)
        })

        sortButton.snp.makeConstraints({ make in
            make.right.equalToSuperview().offset(-69)
            make.top.equalToSuperview().offset(24)
        })
    
    }
}

extension PopularPlacesVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularPlacesTableViewCell

        let object = popularPlaces[indexPath.row]
        cell.configure(with: object)
        
        cell.backgroundColor = UIColor(named: "contentColor")
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = popularPlaces[indexPath.row]
        showDetailViewController(with: selectedPlace)
    }

    private func showDetailViewController(with place: Place) {
        let detailVC = PlaceDetailsVC()
        detailVC.selectedPlace = place
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PopularPlacesVC_Preview: PreviewProvider {
    static var previews: some View {
        PopularPlacesVC().showPreview().ignoresSafeArea()
    }
}
#endif
