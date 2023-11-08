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
    var title: String?
    var subtitle: String?
    var id: String?
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
