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


    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.backgroundColor = .green
        mapView.layer.cornerRadius = 10
        return mapView
    }()

     lazy var placeTitle: UILabel = {
        let label = UILabel()
         label.textColor = .black
        label.font = UIFont(name: "Poppins-SemiBold", size: 30)
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeTitle, dateTitle, authorTitle])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backView.addSubviews(stackView, mapView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
