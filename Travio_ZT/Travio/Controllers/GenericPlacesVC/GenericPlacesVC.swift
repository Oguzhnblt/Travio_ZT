//
//  PopularPlacesVC.swift
//  Travio
//
//  Created by Oğuz on 30.10.2023.
//

import UIKit
import SnapKit

class GenericPlacesVC: UIViewController {
    
    let viewModel = GenericPlacesVM()
    var places = [Place]()
    var sectionType: SectionType?
    
    weak var previousViewController: UIViewController?
    
    
    private var isSorted = false
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppTheme.getColor(name: .content)
        tableView.register(GenericPlacesTableViewCell.self, forCellReuseIdentifier: GenericPlacesTableViewCell.identifier)
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
            places.sort { $0.title!.localizedCompare($1.title!) == .orderedAscending }
        } else {
            places.sort { $0.title!.localizedCompare($1.title!) == .orderedDescending }
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        previousViewController = nil
    }
  
    func fetchData() {
        switch sectionType {
            case .popularPlaces:
                viewModel.popularplacesTransfer = { [weak self] place in
                    self?.places = place
                    self?.updateTableView()
                }
                viewModel.popularPlaces()
            case .newPlaces:
                viewModel.lastPlacesTransfer = { [weak self] place in
                    self?.places = place
                    self?.updateTableView()
                }
                viewModel.newPlaces()
            case .myAddedPlaces:
                viewModel.addedPlacesTransfer = { [weak self] place in
                    self?.places = place
                    self?.updateTableView()
                }
                viewModel.myAddedPlaces()
            case .none:
                break
        }
        
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        setupView(title: title, buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [tableView, sortButton])
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        tableView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(55)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        sortButton.snp.makeConstraints({ make in
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(24)
        })
    }
}

extension GenericPlacesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenericPlacesTableViewCell.identifier, for: indexPath) as! GenericPlacesTableViewCell
        
        let object = places[indexPath.row]
        cell.configure(with: object)
        
        cell.backgroundColor = AppTheme.getColor(name: .content)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = places[indexPath.row]
        showDetailViewController(with: selectedPlace)
    }
    
    private func showDetailViewController(with place: Place?) {
        let detailVC = PlaceDetailsVC()
        detailVC.previousViewController = self
        
        if let selectedPlace = place {
            detailVC.selectedPlace = selectedPlace
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct PopularPlacesVC_Preview: PreviewProvider {
    static var previews: some View {
        GenericPlacesVC().showPreview().ignoresSafeArea()
    }
}
#endif
