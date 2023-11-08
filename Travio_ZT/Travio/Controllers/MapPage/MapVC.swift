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
    
    let viewModel = MapVM()
    private lazy var mapPlaces = [Place]()
    
    private var locationManager: CLLocationManager?
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: mapLayout())
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(MapViewCell.self, forCellWithReuseIdentifier: MapViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
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
    
    
    override func viewDidLoad() {
        setupViews()
        mapData()
        super.viewDidLoad()
        location()
    }
    
    private func mapData() {
        viewModel.dataTransfer = { [weak self] place in
            self?.mapPlaces = place
            self?.collectionView.reloadData()
        }
        viewModel.mapPlaces(limit: 10)
    }
    
    private func location() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let locationInView = gesture.location(in: mapView)
            let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            //            mapView.removeAnnotations(mapView.annotations)
            addCustomPinToMap(at: coordinate)
            
            showPopup()
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            mapView.removeAnnotations(mapView.annotations)
        }
    }
    
    
    func showPopup() {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .popover
        
        if let popover = loginVC.popoverPresentationController {
            popover.sourceView = mapView
            popover.sourceRect = CGRect(x: mapView.bounds.midX, y: mapView.bounds.midY, width: accessibilityFrame.width, height: accessibilityFrame.height)
            popover.permittedArrowDirections = []
            
            present(loginVC, animated: true)
        }
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
                print("Location cannot be determined or is restricted")
            @unknown default:
                print("Unknown error")
        }
    }
    
    
    func addCustomPinToMap(at coordinate: CLLocationCoordinate2D) {
        let customAnnotation = CustomAnnotation(coordinate: coordinate)
        mapView.addAnnotation(customAnnotation)
    }
    
    func setupViews() {
        self.view.addSubviews(mapView, collectionView)
        setupLayout()
    }
    
    func setupLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(600)
            make.left.right.equalToSuperview()
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is CustomAnnotation {
            let senderAnnotation = annotation as! CustomAnnotation
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotation.identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: senderAnnotation, reuseIdentifier: CustomAnnotation.identifier)
                annotationView?.canShowCallout = true
            }
            
            let pinImage = UIImage(named: "myCustomMark")
            annotationView?.image = pinImage
            
            return annotationView
        }
        
        return nil
    }
}

extension MapVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

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
        
        return cell
        
    }
    
    // Cell'e tıklandığında ilgili koordinata git

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedPlace = mapPlaces[indexPath.item]
            let targetCoordinate = CLLocationCoordinate2D(latitude: selectedPlace.latitude!, longitude: selectedPlace.longitude!)
            
            mapView.setCenter(targetCoordinate, animated: false)
        }
}

extension MapVC {
    
    private func mapLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.mapLayouts()
        }
    }
    
    private func mapLayouts() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior  = .groupPaging
        layoutSection.interGroupSpacing = 18
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 650, trailing: 18)
        
        return layoutSection
        
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct MapVC_Preview: PreviewProvider {
    static var previews: some View {
        MapVC().showPreview()
    }
}
#endif
