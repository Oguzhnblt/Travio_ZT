//
//  PlaceBottomView.swift
//  Travio
//
//  Created by Oğuz on 5.11.2023.
//

import UIKit
import SnapKit
import MapKit


class PlaceBottomView: UICollectionViewCell {
    
    static let identifier = "bottomView"

    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var placeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Türkiye"
        label.font = UIFont(name: "Poppins-SemiBold", size: 30)
        label.numberOfLines = -1
        return label
    }()

    lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()

    lazy var authorTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Poppins-Regular", size: 10)
        return label
    }()

    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.layer.cornerRadius = 16
        mapView.delegate = self
        return mapView
    }()

 
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeTitle, dateTitle, authorTitle])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
   
  
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
    private func setupViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(backView)
        backView.addSubviews(stackView,mapView, descriptionLabel)

        backView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.width.equalTo(frame.width)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        mapView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(9)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(220)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
    }
}

extension PlaceBottomView: MKMapViewDelegate {
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
