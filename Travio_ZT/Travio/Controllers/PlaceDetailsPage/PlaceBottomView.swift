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
    
    func configure(with place: Place) {
           placeTitle.text = place.title
           descriptionLabel.text = place.description
       }
       
    
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
        label.font = UIFont(name: "Poppins-SemiBold", size: 30)
        label.numberOfLines = 0
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
        return mapView
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeTitle, dateTitle, authorTitle])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
     lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fringilla suscipit turpis, id ultricies velit laoreet quis. Nulla nunc eros, luctus at faucibus nec, scelerisque quis diam. Etiam vel justo eu nisi malesuada pharetra. Vivamus pulvinar ultrices rhoncus. Fusce tempor lacus eu arcu dapibus, non faucibus nisl dapibus. Etiam tellus tortor, vulputate ut nulla quis, blandit pharetra augue. In odio erat, varius nec rhoncus sed, pretium ut dui. Nunc at mattis velit. Proin semper justo est, ac rutrum ipsum varius nec.Phasellus in dapibus mauris, vitae ultrices tellus. Nam posuere diam sit amet nulla maximus placerat. Aliquam tincidunt, libero eu rhoncus hendrerit, purus sem blandit nulla, vel pellentesque quam dui vitae est. Nunc dictum, sapien ac gravida facilisis, arcu libero porttitor metus, a lobortis tellus quam eu nibh. Ut non mi bibendum nisl porta tincidunt sit amet pulvinar velit. Sed at purus mollis odio ornare pulvinar quis luctus ipsum. Cras et enim nisi. Vestibulum eget ligula scelerisque, lacinia arcu et, luctus nisi. Praesent faucibus massa sed metus porta, id accumsan eros efficitur. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam finibus neque ut erat tempor, ultrices aliquet erat tempor. Mauris efficitur lobortis tortor et varius. Duis nisl magna, vestibulum ac purus nec, placerat vestibulum lacus. Proin facilisis nisl a elit accumsan, vitae euismod mauris bibendum. Proin porttitor tellus eget commodo scelerisque. Donec varius sollicitudin ultrices. Fusce condimentum at lorem sed lobortis. Vestibulum non leo lacinia, eleifend purus eget, porta nisl. Duis sit amet sodales mauris. Etiam lectus mauris, vulputate ut eleifend sed, malesuada eu metus. Sed rhoncus leo eu varius accumsan. Cras at justo id est pulvinar consectetur ac id odio. Suspendisse porttitor at enim euismod efficitur. Fusce pulvinar nec eros non laoreet. Suspendisse a scelerisque enim. Proin a velit nec orci lobortis hendrerit ut in massa. Vestibulum dignissim, mauris in imperdiet placerat, nibh lorem pretium nisl, ut hendrerit magna urna vitae ipsum. Aenean in lobortis lorem. Maecenas posuere nulla et quam efficitur dictum. Ut posuere massa lorem, et pharetra ligula faucibus fringilla. Donec faucibus posuere lorem, sed viverra mauris semper id. Suspendisse potenti. Nulla facilisi. Morbi ac euismod nisl. Vestibulum eu posuere mauris, ac eleifend magna. Fusce vitae sem eu urna finibus euismod. Duis sem erat, feugiat at vestibulum nec, accumsan eget elit. Pellentesque egestas placerat metus, venenatis tempus mauris porttitor ut. Aenean et erat dapibus, scelerisque enim quis, euismod massa. Donec mollis est sodales fringilla sagittis. Nam vitae convallis tortor, auctor auctor dolor. Donec dapibus erat massa, id tincidunt mi bibendum vitae. Nulla facilisi. Maecenas sed venenatis nunc, non mollis mi. Suspendisse porttitor at enim euismod efficitur. Fusce pulvinar nec eros non laoreet. Suspendisse a scelerisque enim. Proin a velit nec orci lobortis hendrerit ut in massa. Vestibulum dignissim, mauris in imperdiet placerat, nibh lorem pretium nisl, ut hendrerit magna urna vitae ipsum. Aenean in lobortis lorem. Maecenas posuere nulla et quam efficitur dictum. Ut posuere massa lorem, et pharetra ligula faucibus fringilla. Donec faucibus posuere lorem, sed viverra mauris semper id. Suspendisse potenti. Nulla facilisi. Morbi ac euismod nisl. Vestibulum eu posuere mauris, ac eleifend magna. Fusce vitae sem eu urna finibus euismod. Duis sem erat, feugiat at vestibulum nec, accumsan eget elit. Pellentesque egestas placerat metus, venenatis tempus mauris porttitor ut. Aenean et erat dapibus, scelerisque enim quis, euismod massa. Donec mollis est sodales fringilla sagittis. Nam vitae convallis tortor, auctor auctor dolor. Donec dapibus erat massa, id tincidunt mi bibendum vitae. Nulla facilisi. Maecenas sed venenatis nunc, non mollis mi."
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
        backView.addSubviews(stackView, mapView, descriptionLabel)

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
            make.height.equalTo(200)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
