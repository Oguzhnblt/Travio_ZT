//
//  HomeVC.swift
//  Travio
//
//  Created by Oğuz on 25.10.2023.
//

import UIKit
import SnapKit


class HomeVC: UIViewController, UICollectionViewDelegate {
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16

        
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "homeCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        return collectionView
        
    }()
    
    private func stackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = .fillProportionally
        stackView.spacing = spacing
        stackView.alignment = .center
        return stackView
    }
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    
    private lazy var loginItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "homePage_icon")
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {

        self.view.addSubviews(loginView,imageView)
        loginView.addSubview(loginItemView)
        loginItemView.addSubview(collectionView)
        
        setupLayouts()
        
    }
    
    
    private func setupLayouts() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints({make in
            make.top.equalTo(loginView).offset(43)
            make.left.equalTo(loginView).offset(16)
        })
        
        loginItemView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(125)
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints({make in
            make.edges.equalToSuperview().offset(86)
            make.left.equalTo(24)
            make.right.equalTo(-24)
        })
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    // Her bir item'in boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

extension HomeVC: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        cell.imageView.image = .imgColleseum
        cell.titleLabel.text = "Colleseum"
        cell.subtitleLabel.text = "Rome"
        
        return cell
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View{
         
        HomeVC().showPreview()
    }
}
#endif
