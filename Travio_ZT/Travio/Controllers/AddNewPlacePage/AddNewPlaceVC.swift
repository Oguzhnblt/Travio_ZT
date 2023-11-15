//
//  AddNewPlaceVC.swift
//  Travio
//
//  Created by Oğuz on 9.11.2023.
//

import Foundation
import UIKit
import SnapKit
import MapKit

class AddNewPlaceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedCoordinate: CLLocationCoordinate2D?
    
    private lazy var addPlaceButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Add Place", for: .normal)
        saveButton.addTarget(self, action: #selector(addPlaceButtonTapped), for: .touchUpInside)
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = UIColor(named: "backgroundColor")
        return saveButton
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: addNewPageLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "contentColor")
        collectionView.register(AddNewPlaceViewCell.self, forCellWithReuseIdentifier: AddNewPlaceViewCell.identifier)
        collectionView.register(AddPhotoViewCell.self, forCellWithReuseIdentifier: AddPhotoViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
   
    private func updateLocationInfo() {
        guard let selectedCoordinate = selectedCoordinate else { return }
        
        let location = CLLocation(latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first, error == nil else {return}
            
            let country = placemark.country!
            let city = placemark.locality!
            
            let indexPath = IndexPath(item: 0, section: 2)
            if let cell = self?.collectionView.cellForItem(at: indexPath) as? AddNewPlaceViewCell {
                cell.textView.text = "\(city), \(country)"
            }
        }
    }
    
    @objc func addPlaceButtonTapped() {
        // Sunucuya veri ekleme işlemi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocationInfo()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubviews(collectionView, addPlaceButton)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addPlaceButton.snp.makeConstraints({make in
            make.bottom.equalTo(collectionView.snp.bottom).offset(-50)
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
                let cell: AddPhotoViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoViewCell.identifier, for: indexPath) as! AddPhotoViewCell
                
                return cell
            default:
                fatalError()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showImagePicker(for: indexPath)
    }
    
    func showImagePicker(for indexPath: IndexPath) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.view.tag = indexPath.item
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }

        let indexPath = IndexPath(item: picker.view.tag, section: 3)
        if let cell = self.collectionView.cellForItem(at: indexPath) as? AddPhotoViewCell {
            cell.imageView.image = selectedImage
        }

        picker.dismiss(animated: true, completion: nil)
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
        AddNewPlaceVC().showPreview().ignoresSafeArea()
    }
}
#endif
