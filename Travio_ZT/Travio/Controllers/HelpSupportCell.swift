//
//  HelpSupportCell.swift
//  Travio
//
//  Created by Oğuz on 2.11.2023.
//

import Foundation
import UIKit
import SnapKit

class HelpSupportCell: UICollectionViewCell, UITextViewDelegate {

    var textView: UITextView!
    var expanded: Bool = false {
        didSet {
            // expanded değeri değiştiğinde, hücrenin görünümünü güncelle
            updateCellLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // TextView oluştur
        textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.text = "Başlangıç metni"
        textView.isEditable = true
        textView.delegate = self

        // TextView'i hücreye ekle
        contentView.addSubview(textView)

        // SnapKit kullanarak TextView'i konumlandır
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }

        // UITapGestureRecognizer ekle
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UITapGestureRecognizer ile hücreye tıklanınca çalışacak fonksiyon
    @objc func handleTap() {
        expanded.toggle() // expanded değerini tersine çevir
    }

    // TextView içeriği değiştiğinde çağrılır
    func textViewDidChange(_ textView: UITextView) {
        // Eğer text değişirse, delegate'e haber ver
//        delegate?.textViewDidChange(textView)
    }

    // expanded değerine göre hücrenin görünümünü güncelle
    private func updateCellLayout() {
        if expanded {
            textView.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            }
        } else {
            textView.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalToSuperview().offset(-20)
                make.height.equalTo(30)
            }
        }
    }
}


