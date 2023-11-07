import UIKit
import SnapKit
import MapKit

class MapVC: UIViewController {
    
    var locationManager: CLLocationManager?
    
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
        setupLayout()
    }
    
    func setupLayout() {
        mapView.snp.makeConstraints({ map in
            map.top.bottom.equalToSuperview()
            map.left.right.equalToSuperview()
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



