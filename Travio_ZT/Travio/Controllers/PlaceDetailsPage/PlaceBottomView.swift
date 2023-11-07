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

    private lazy var scrollView: UIView = {
        let scrollView = UIView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.numberOfLines = 0
        return label
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 16
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

        backView.addSubviews(stackView, mapView, scrollView)
        scrollView.addSubview(textLabel)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(24)
            make.left.equalToSuperview().offset(24)
        }

        mapView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints({make in
            make.top.equalTo(mapView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        })
        
        textLabel.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview().offset(16)
            make.left.right.equalToSuperview()
        })
    }

}
