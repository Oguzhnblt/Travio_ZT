//
//  CustomAnnotation.swift
//  Travio
//
//  Created by web3406 on 7.11.2023.
//

import Foundation
import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    static let identifier = "mapAnnotation"
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D, image: UIImage?) {
        self.coordinate = coordinate
        self.image = image
        super.init()
    }
}


