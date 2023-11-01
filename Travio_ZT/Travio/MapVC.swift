//
//  
//  MapVC.swift
//  Travio
//
//  Created by web3406 on 31.10.2023.
//
//
import UIKit
import SnapKit
import MapKit

class MapVC: UIViewController, CLLocationManagerDelegate {
    
    private lazy var mapView : MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupViews()
       
    }
    
 
    func setupViews() {
        
        self.view.addSubviews(mapView)
        setupLayout()
    }
    
    func setupLayout() {
        
        mapView.snp.makeConstraints({map in
            map.top.bottom.equalToSuperview()
            map.left.right.equalToSuperview()
        })
      
       
    }
  
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MapVC_Preview: PreviewProvider {
    static var previews: some View{
         
        MapVC().showPreview()
    }
}
#endif
