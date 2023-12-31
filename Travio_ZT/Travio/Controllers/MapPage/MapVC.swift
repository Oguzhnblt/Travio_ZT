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
    
    private lazy var viewModel = MapVM()
    private lazy var mapPlaces: [Place] = []
    
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
        map.overrideUserInterfaceStyle = .light
        map.isScrollEnabled = true
        map.isZoomEnabled = true
        map.delegate = self
        return map
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Nereye gitmek istiyorsunuz?"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        return gesture
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideSearchBar))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    private lazy var zoomPress: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressOnCell(_:)))
        gesture.minimumPressDuration = 0.5
        return gesture
    }()
    
    private func tapGestureMethods() {
        mapView.addGestureRecognizer(longPressGesture)
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tapGestureMethods()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapData()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.addSubviews(mapView, collectionView,searchBar)
        setupLayout()
    }
    
    private func setupLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        })
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height * 0.65)
            make.bottom.equalToSuperview().offset(view.frame.height * 0.75)
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
    }
    
    private func updateMapAndCollection() {
        mapView.removeAnnotations(mapView.annotations)
        
        for place in mapPlaces {
            if let latitude = place.latitude, let longitude = place.longitude {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                addCustomPinToMap(at: coordinate)
            }
        }
        collectionView.reloadData()
    }
    
    
    
    
    // MARK: - Map Functions
    
    private func addCustomPinToMap(at coordinate: CLLocationCoordinate2D) {
        let annotation = MapAnnotation(coordinate: coordinate, image: UIImage(named: "icon_map_mark"))
        mapView.addAnnotation(annotation)
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


// MARK: - MKMapViewDelegate

extension MapVC: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else { return }
        if let index = mapPlaces.firstIndex(where: { $0.latitude == coordinate.latitude && $0.longitude == coordinate.longitude }) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MapAnnotation else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapAnnotation.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapAnnotation.identifier)
            annotationView!.canShowCallout = false
        } else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.image = (annotation as? MapAnnotation)?.image
        
        return annotationView
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            cell.addGestureRecognizer(zoomPress)
        }
    }
    
    @objc private func handleLongPressOnCell(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            if let cell = gesture.view as? MapViewCell, let indexPath = collectionView.indexPath(for: cell) {
                let selectedPlace = mapPlaces[indexPath.item]
                if let latitude = selectedPlace.latitude, let longitude = selectedPlace.longitude {
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
                    mapView.setRegion(region, animated: true)                    }
            }
        }
    }
}

extension MapVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = mapPlaces[indexPath.item]
        showDetailViewController(with: selectedPlace)
        
    }
    
    private func showDetailViewController(with place: Place) {
        let detailVC = PlaceDetailsVC()
        detailVC.selectedPlace = place
        detailVC.selectedCoordinates = CLLocationCoordinate2D(latitude: place.latitude!, longitude: place.longitude!)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension MapVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        locationSearch(query: searchBar.text)
    }
    
    @objc private func handleTapOutsideSearchBar(_ gesture: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
}


// MARK: - Helper Methods

extension MapVC {
    
    private func locationSearch(query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                self.showAlert(title: "Hata", message: "\(query) bulunamadı.", actionTitle: "Tamam")
                return
            }
            
            let placemarks = response.mapItems
            if let firstPlacemark = placemarks.first {
                let coordinate = firstPlacemark.placemark.coordinate
                self.updateMap(coordinate: coordinate)
            }
        }
    }
    
    private func updateMap(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        collectionView.reloadData()
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
