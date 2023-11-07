import UIKit
import SnapKit
import MapKit

class MapVC: UIViewController {
    
    var locationManager: CLLocationManager?
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: mapLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
 
        collectionView.register(MapViewCell.self, forCellWithReuseIdentifier: MapViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = true
        map.overrideUserInterfaceStyle = .dark
        map.delegate = self
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)

    }
    
    func setupViews() {
        self.view.addSubview(mapView)
        self.view.addSubview(collectionView)
        setupLayout()
    }
    
    func setupLayout() {
        mapView.snp.makeConstraints({ map in
            map.top.bottom.equalToSuperview()
            map.left.right.equalToSuperview()
            })
        collectionView.snp.makeConstraints({ make in
               make.top.equalToSuperview().offset(565)
               make.bottom.equalToSuperview().offset(-101)
               make.left.equalToSuperview()
               make.right.equalToSuperview()
           })
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
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
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let locationInView = gesture.location(in: mapView)
            let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            mapView.removeAnnotations(mapView.annotations)
            addCustomPinToMap(at: coordinate)
            showPopup()

        }
    }
    func showPopup(){
        let screenHeight = UIScreen.main.bounds.height
        let popupHeight = screenHeight * 0.8

        
        let loginVC = LoginVC()
        loginVC.view.frame = CGRect(x: 0, y: screenHeight, width: self.view.frame.width, height: popupHeight)
        self.view.addSubview(loginVC.view)


        UIView.animate(withDuration: 0.3) {
            loginVC.view.frame = CGRect(x: 0, y: screenHeight - popupHeight, width: self.view.frame.width, height: popupHeight)
        }
    }



    func addCustomPinToMap(at coordinate: CLLocationCoordinate2D) {
        let customAnnotation = CustomAnnotation(coordinate: coordinate)
        mapView.addAnnotation(customAnnotation)
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
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomAnnotation")

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: senderAnnotation, reuseIdentifier: "CustomAnnotation")
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
        return popularPlacesMockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapViewCell.identifier, for: indexPath) as! MapViewCell
        cell.cellData = popularPlacesMockData[indexPath.row]
        return cell
        
    }
}

extension MapVC {

   private func mapLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return self.mapLayouts()
        }
    }

    private func mapLayouts() -> NSCollectionLayoutSection {
       
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)


        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitem: layoutItem, count: 1)

        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging

        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        layoutSection.interGroupSpacing = 16

        return layoutSection
    }
}




