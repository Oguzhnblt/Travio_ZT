//
//  MainTabbarVC.swift
//  Travio
//
//  Created by web3406 on 26.10.2023.
//
//

import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            self.viewControllers = setupControllers()
                    self.selectedIndex = 2
                    self.tabBar.tintColor = .systemBlue
                    self.tabBar.unselectedItemTintColor = .systemGray5
                    self.tabBar.backgroundColor = .white
                    self.tabBar.isTranslucent = false
        }
        
        private func setupControllers()->[UIViewController]{
            let homeVC = HomeVC()
                    let homeNC = UINavigationController(rootViewController: homeVC)
                    let imageHome =  UIImage(systemName: "house")
                    let selectedImageHome = UIImage(systemName: "house.fill")
                    homeVC.tabBarItem = UITabBarItem(title: "Home", image: imageHome, selectedImage: selectedImageHome)
            
            return [homeNC]
        }
    

   
}
