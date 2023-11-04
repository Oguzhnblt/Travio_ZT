//
//  HelpSupportCellü.swift
//  Travio
//
//  Created by Oğuz on 4.11.2023.
//

import Foundation
import UIKit
import SnapKit

class HelpSupportCell: UIView {
    
    
    static let field = HelpSupportCell()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16

        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Poppins-Regular", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var toogle: UIButton = {
        let toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Toggle", for: .normal)
        return toggleButton
    }()
    
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    func configure(title: String, subtitle: String ) {
        label.text = title
        subtitleLabel.text = subtitle
    }
    
    
    private func setupViews() {
        self.addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(60) // Initial height

        }
        
        backView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

