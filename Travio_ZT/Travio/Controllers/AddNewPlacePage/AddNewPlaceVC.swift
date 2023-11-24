import Foundation
import UIKit
import SnapKit
import MapKit

class AddNewPlaceVC: UIViewController {
    
    private lazy var placeNameIndexPath = IndexPath(item: 0, section: 0)
    private lazy var placeDescriptionIndexPath = IndexPath(item: 0, section: 1)
    private lazy var locationIndexPath = IndexPath(item: 0, section: 2)
    
    private var blurEffectView: UIVisualEffectView?
    var selectedCoordinate: CLLocationCoordinate2D?
    private lazy var addPlaceImages: [UIImage] = []
    private lazy var viewModel = AddNewPlaceVM()
    var completedAddPlace: (() -> Void)?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var activityIndicatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Yeni yer ekleniyor lütfen bekleyiniz."
        label.textAlignment = .center
        label.font = AppTheme.getFont(name: .regular, size: .size14)
        return label
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
    
    private lazy var addPlaceButton = ButtonUtility.createButton(from: self, title: "Add Place", action: #selector(addPlaceButtonTapped))
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateLocationInfo()
        hideBlurEffect()
    }
    
    // MARK: Private Methods
    private func setupViews() {
        view.addSubviews(collectionView, addPlaceButton, activityIndicator)
        activityIndicator.addSubview(activityIndicatorLabel)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-90)
        }
        
        activityIndicatorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activityIndicator.snp.bottom).offset(8)
        }
        
        addPlaceButton.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(342)
            make.height.equalTo(54)
        }
    }
    
    private func showIndicator(state: IndicatorState) {
        switch state {
            case .start:
                activityIndicator.startAnimating()
                showBlurEffect()
            case .stop:
                activityIndicator.stopAnimating()
                hideBlurEffect()
        }
    }
    
    private func showBlurEffect() {
        let blurEffect = UIBlurEffect(style: .prominent)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        blurEffectView?.contentView.addSubview(activityIndicator)
    }
    
    private func hideBlurEffect() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    private func updateLocationInfo() {
        guard let selectedCoordinate = selectedCoordinate else { return }
        
        let location = CLLocation(latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first, error == nil,
                  let country = placemark.country ?? placemark.areasOfInterest?.first,
                  let city = placemark.locality
            else { return }
            
            if let cell = self?.collectionView.cellForItem(at: self!.locationIndexPath) as? AddNewPlaceViewCell {
                cell.textView.text = "\(city), \(country)"
            }
        }
    }
    
    @objc private func addPlaceButtonTapped() {
        guard
            let placeNameCell = collectionView.cellForItem(at: placeNameIndexPath) as? AddNewPlaceViewCell,
            let placeDescriptionCell = collectionView.cellForItem(at: placeDescriptionIndexPath) as? AddNewPlaceViewCell,
            let locationCell = collectionView.cellForItem(at: locationIndexPath) as? AddNewPlaceViewCell
        else { return }
        
        if placeNameCell.textView.text?.isEmpty ?? true ||
            placeDescriptionCell.textView.text?.isEmpty ?? true ||
            locationCell.textView.text?.isEmpty ?? true {
            Alerts.showAlert(from: self, title: "Uyaru", message: "Lütfen tüm alanları doldurun.", actionTitle: "Tamam")
            return
        }
        
        showIndicator(state: .start)
        
        let place = locationCell.textView.text ?? ""
        let title = placeNameCell.textView.text ?? ""
        let description = placeDescriptionCell.textView.text ?? ""
        
        viewModel.uploadImage(images: addPlaceImages)
        
        viewModel.transferURLs = { [weak self] urls in
            guard let self = self else { return }
            
            let params: [String: Any] = [
                "place": place,
                "title": title,
                "description": description,
                "cover_image_url": urls.first!,
                "latitude": self.selectedCoordinate!.latitude as Double,
                "longitude": self.selectedCoordinate!.longitude as Double
            ]
            viewModel.addPlace(params: params)
            
            viewModel.transferPlaceID = { [weak self] placeId in
                guard let self = self else { return }
                for imageUrl in urls {
                    let params = ["place_id": placeId, "image_url": imageUrl]
                    viewModel.postGalleryImage(params: params)
                }
              
            }
            completedAddPlace?()
            showIndicator(state: .stop)
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: UICollectionViewDataSource

extension AddNewPlaceVC: UICollectionViewDataSource {
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
            case 1:
                cell.textLabel.text = "Visit Description"
            case 2:
                cell.textLabel.text = "City, Country"
            default:
                break
        }
    }
}

// MARK: UICollectionViewDelegate

extension AddNewPlaceVC: UICollectionViewDelegate {
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
}

// MARK: UIImagePickerControllerDelegate

extension AddNewPlaceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        
        let indexPath = IndexPath(item: picker.view.tag, section: 3)
        
        guard indexPath.section < collectionView.numberOfSections, indexPath.item < collectionView.numberOfItems(inSection: indexPath.section) else {return}
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AddPhotoViewCell {
            cell.imageView.image = selectedImage
            
            if indexPath.item < addPlaceImages.count { 
                addPlaceImages[indexPath.item] = selectedImage
            }
            else {
                addPlaceImages.append(selectedImage)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
// MARK: Compositional Layout

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
