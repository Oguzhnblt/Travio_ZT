//
//  AboutUsVC.swift
//  Travio
//
//  Created by Oğuz on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AboutUsVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    

    
    private func setupViews() {
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        setupView(title: "About Us",buttonImage: UIImage(named: "leftArrowIcon"), buttonPosition: .left, headerLabelPosition: .center, buttonAction: #selector(buttonTapped), itemsView: [UIView()])

    }
}

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct AboutUsVC_Preview: PreviewProvider {
    static var previews: some View {
        AboutUsVC().showPreview()
    }
}
#endif
