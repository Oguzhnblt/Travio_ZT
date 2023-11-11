//
//  AddNewPlaceCell.swift
//  Travio
//
//  Created by Oğuz on 9.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddNewPlaceViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()
    
    lazy var textView: UITextView = {
        let textField = UITextView()
        textField.textColor = UIColor.gray
        textField.backgroundColor = UIColor.white
        textField.font = UIFont(name: "Poppins-Regular", size: 12)
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textLabel, textView])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    func configure(text: String, fieldText: String) {
        textLabel.text = text
        textView.text = fieldText
    }
    
    
    private func setupViews() {
        self.addSubview(backView)
        backView.addSubview(stackView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        dropShadow()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

