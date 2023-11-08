//
//  SignCell.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.

import UIKit
import SnapKit

class EditingProfileCell: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        return label
    }()
    
    let signImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
    
        return image
    }()
    
    private func setupViews() {
        self.addSubview(backView)
        
        let stackView = UIStackView(arrangedSubviews: [signImage, label])
        stackView.axis = .horizontal
        stackView.spacing = 8
        backView.addSubview(stackView)
        
        backView.dropShadow()
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.width.equalTo(164)
            make.height.equalTo(54)

        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        signImage.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(text: String, image: UIImage) {
        label.text = text
        signImage.image = image
    }
}
