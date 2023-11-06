//
//  PopularPlacesVC.swift
//  Travio
//
//  Created by Oğuz on 30.10.2023.
//

import UIKit
import SnapKit

class PopularPlacesVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(PopularPlacesViewCell.self, forCellWithReuseIdentifier: "popularCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var popularPlacesView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    
    private lazy var popularPlacesItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "contentColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = .layerMinXMinYCorner
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var sortDownToUpButton: UIButton = {
        let sort = UIButton(type: .custom)
        sort.setImage(UIImage(named: "img_down_sort"), for: .normal)
        sort.addTarget(self, action: #selector(sortDown), for: .touchUpInside)


       return sort
    }()
    
    private lazy var sortUpToDownButton: UIButton = {
        let sort = UIButton(type: .custom)
        sort.setImage(UIImage(named: "img_up_sort"), for: .normal)
        sort.addTarget(self, action: #selector(sortUp), for: .touchUpInside)
       return sort
    }()
    
    
    
    private func createLabel(text: String,textSize: CGFloat, fontName: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: "textFieldBackground")
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: fontName, size: textSize)
        return label
    }
    
    
    private lazy var titlelabel = createLabel(text: "Popular Places", textSize: 32, fontName: "Poppins-SemiBold")
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sortDown() {
        
    }
    
    @objc func sortUp() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
    }
    
    
    private func setupViews() {
        
        self.view.addSubviews(popularPlacesView,titlelabel, backButton)
        popularPlacesView.addSubview(popularPlacesItemView)
        popularPlacesItemView.addSubviews(collectionView,sortUpToDownButton,sortDownToUpButton)
        
        
        setupLayouts()
        
    }
    
    private func setupLayouts() {
        
        sortUpToDownButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
        })
        
        sortDownToUpButton.snp.makeConstraints({make in
            make.right.equalToSuperview().offset(-69)
            make.top.equalToSuperview().offset(24)


        })
        
        backButton.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            make.left.equalToSuperview().offset(24)
        })
        
        popularPlacesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titlelabel.snp.makeConstraints({make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(19)
            make.centerX.equalTo(popularPlacesView)
        })
        
        popularPlacesItemView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(125)
            make.edges.equalToSuperview()
        }
        
        collectionView.dropShadow()
        collectionView.snp.makeConstraints({make in
            make.top.bottom.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            
        })
    }
}

extension PopularPlacesVC: UICollectionViewDelegateFlowLayout {
    
    // Her bir item'in boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension PopularPlacesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularPlacesMockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularPlacesViewCell
        
        let place = popularPlacesMockData[indexPath.row]
        
        cell.titleLabel.text = place.title
        cell.subtitleLabel.text = place.place
        
        // FIXME: -- Mock data ile işlem yapmayı bitirdiğinde burayı düzelt.
        // Eğer place.cover_img_url boş bir dize veya sadece boşluk içeriyorsa veya dosya asset içinde yoksa
        
        if let imgUrl = place.cover_img_url, !imgUrl.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let image = UIImage(named: imgUrl) {
            cell.imageView.image = image
        } else {
            cell.imageView.image = UIImage(named: "img_default")
        }
        
        
        
        return cell
    }
}

extension PopularPlacesVC {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let section = HomePageLayout.shared.popularPlacesLayout()
        return UICollectionViewCompositionalLayout(section: section)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct PopularPlacesVC_Preview: PreviewProvider {
    static var previews: some View {
        PopularPlacesVC().showPreview()
    }
}
#endif

