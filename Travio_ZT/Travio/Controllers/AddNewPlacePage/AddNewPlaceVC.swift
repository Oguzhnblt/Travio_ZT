//
//  AddNewPlaceVC.swift
//  Travio
//
//  Created by Oğuz on 9.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddNewPlaceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var addPlaceButton: UIButton = {
        
        let saveButton = UIButton()
        saveButton.setTitle("Add Place", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = UIColor(named: "backgroundColor")
        return saveButton
    }()
    

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: addNewPageLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.content
        collectionView.register(AddNewPlaceViewCell.self, forCellWithReuseIdentifier: AddNewPlaceViewCell.identifier)
        collectionView.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()
    
    @objc func saveButtonTapped() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.view.addSubviews(collectionView, addPlaceButton)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addPlaceButton.snp.makeConstraints({make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(342)
            make.height.equalTo(54)
        })
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return 1
        case 3:
            return 3
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0, 1, 2:
            let cell: AddNewPlaceViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewPlaceViewCell.identifier, for: indexPath) as! AddNewPlaceViewCell
            configureTextCell(cell, for: indexPath.section)
            return cell
        case 3:
            let cell: AddPhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCell.identifier, for: indexPath) as! AddPhotoCell
                
                // FIXME: Düzenlenecek
            
            return cell
        default:
            fatalError("Unexpected section")
        }
    }

    private func configureTextCell(_ cell: AddNewPlaceViewCell, for section: Int) {
        switch section {
        case 0:
            cell.textLabel.text = "Place Name"
            cell.textView.text = "Please write a place name"
        case 1:
            cell.textLabel.text = "Visit Description"
            cell.textView.text = "Your long description here..."
        case 2:
            cell.textLabel.text = "Country, City"
            cell.textView.text = "France, Paris"
        default:
            break
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

extension AddNewPlaceVC {
    func addNewPageLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            return AddNewPlaceLayout.shared.makePlacesLayout(forSection: sectionNumber)
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AddNewPlaceVC_Preview: PreviewProvider {
    static var previews: some View {
        AddNewPlaceVC().showPreview()
    }
}
#endif
