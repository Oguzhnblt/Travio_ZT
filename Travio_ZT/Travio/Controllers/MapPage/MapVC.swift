//
//  MapVC.swift
//  Travio
//
//  Created by Oğuz on 8.11.2023.
//

import UIKit
import SnapKit
import MapKit

class MapVC: UIViewController {
    
    // MARK: - Properties
    
    let viewModel = MapVM()
    private var mapPlaces = [Place]()
    private var locationManager: CLLocationManager?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MapPageLayout.shared.mapLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        collectionView.register(MapViewCell.self, forCellWithReuseIdentifier: MapViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.overrideUserInterfaceStyle = .dark
        map.isScrollEnabled = true
        map.isZoomEnabled = true
        map.delegate = self
        return map
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        mapData()
        location()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
        
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.addSubviews(mapView, collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(550)
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: - Data Handling
    
    private func mapData() {
        viewModel.mapPlaces()
        
        viewModel.dataTransfer = { [weak self] places in
            self?.mapPlaces = places
            self?.updateMapAndCollection()
        }
        
        updateMapAndCollection()
    }

    
    private func updateMapAndCollection() {        
        for place in mapPlaces {
            if let latitude = place.latitude, let longitude = place.longitude {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                addCustomPinToMap(at: coordinate)
            }
        }
        
        collectionView.reloadData()
    }
    
    // MARK: - Location Handling
    
    private func location() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
    }
    
    
    // MARK: - Map Functions
    
    private func addCustomPinToMap(at coordinate: CLLocationCoordinate2D) {
        let customAnnotation = MapAnnotation(coordinate: coordinate)
        mapView.addAnnotation(customAnnotation)
    }
    
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager, let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
                mapView.setRegion(region, animated: true)
            case .denied:
                print("Location services have been denied")
            case .notDetermined, .restricted:
                print("Location authorization is undetermined or restricted")
            @unknown default:
                fatalError()
        }
    }
    
    // MARK: - Popup
    
    
    private func showPopup(at coordinate: CLLocationCoordinate2D) {
        let addNewPlace = AddNewPlaceVC()
        addNewPlace.selectedCoordinate = coordinate
        addNewPlace.modalPresentationStyle = .popover
        
        if let popover = addNewPlace.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = view.bounds
            popover.permittedArrowDirections = []
            
            addNewPlace.completedAddPlace = { [weak self] in
                self?.mapData()
            }
            
            present(addNewPlace, animated: true, completion: nil)
        }
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let touchPoint = gesture.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            showPopup(at: coordinate)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MapVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - MKMapViewDelegate

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MapAnnotation {
            let senderAnnotation = annotation as! MapAnnotation
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapAnnotation.identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: senderAnnotation, reuseIdentifier: MapAnnotation.identifier)
                annotationView?.canShowCallout = true
                
                let disclosureButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = disclosureButton
            }
            
            let pinImage = UIImage(named: "myCustomMark")
            annotationView?.image = pinImage
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else { return }
        if let index = mapPlaces.firstIndex(where: { $0.latitude == coordinate.latitude && $0.longitude == coordinate.longitude }) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionViewDataSource

extension MapVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapViewCell.identifier, for: indexPath) as! MapViewCell
        let object = mapPlaces[indexPath.item]
        cell.configure(with: object)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        cell.addGestureRecognizer(doubleTapGesture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = mapPlaces[indexPath.item]
        showDetailViewController(with: selectedPlace)
    }
    
    private func showDetailViewController(with place: Place) {
        let detailVC = PlaceDetailsVC()
        detailVC.selectedPlace = place
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if let cell = gesture.view as? MapViewCell, let indexPath = collectionView.indexPath(for: cell) {
                let selectedPlace = mapPlaces[indexPath.item]
                let coordinate = CLLocationCoordinate2D(latitude: selectedPlace.latitude!, longitude: selectedPlace.longitude!)
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView.setRegion(region, animated: true)
            }
        }
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MapVC_Preview: PreviewProvider {
    static var previews: some View {
        MapVC().showPreview().ignoresSafeArea()
    }
}
#endif
