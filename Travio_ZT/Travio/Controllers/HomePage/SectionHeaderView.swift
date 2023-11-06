//
//  CategoryHeaderView.swift
//  Travio
//
//  Created by Oğuz on 28.10.2023.
//

import Foundation
import UIKit
import SnapKit


class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
      let subtitle = UILabel()
      let button = UIButton()

      override init(frame: CGRect) {
          super.init(frame: frame)

          let separator = UIView()

          title.textColor = .black
          title.font = UIFont(name: "Poppins-Regular", size: 20)

          button.setTitle("See All", for: .normal)
          button.setTitleColor(.background, for: .normal)
          button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)

          let stackView = UIStackView(arrangedSubviews: [title, separator, button])
          stackView.axis = .horizontal
          addSubview(stackView)

          stackView.snp.makeConstraints { make in
              make.edges.equalToSuperview()
                  .inset(
                    UIEdgeInsets(top: 55, left: 18, bottom: 0, right: 35)
                  )
          }
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



