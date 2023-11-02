//
//  SignCell.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.
//

import UIKit
import SnapKit

class SignCell: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var signImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8.0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signImage, label])
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backView)
        
        backView.addSubview(stackView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func configure(text: String, image: UIImage) {
        label.text = text
        signImage.image = image
    }
}
