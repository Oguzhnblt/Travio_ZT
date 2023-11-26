//
//  MainTabbarVC.swift
//  Travio
//
//  Created by web3406 on 26.10.2023.
//  background: #FFFFFFBF;

import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = setupControllers()
        self.selectedIndex = 0
        self.tabBar.tintColor = AppTheme.getColor(name: .background)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        self.tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tabBar.isTranslucent = true
    }

    private func setupControllers() -> [UIViewController] {
        let homeVC = HomeVC()
        let homeNC = UINavigationController(rootViewController: homeVC)
        let imageHome =  UIImage(systemName: "house")
        let selectedImageHome = UIImage(systemName: "house.fill")
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: imageHome, selectedImage: selectedImageHome)

        let settingsVC = SettingsVC()
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        let imageSettings =  UIImage(named: "menu")
        let selectedImageSettings = UIImage(named: "menu")
        settingsVC.tabBarItem = UITabBarItem(title: "Menu", image: imageSettings, selectedImage: selectedImageSettings)

        let myVisitsVC = MyVisitsVC()
        let myVisitsNC = UINavigationController(rootViewController: myVisitsVC)
        let imageVisits =  UIImage(named: "tabBarPin")
        let selectedImageVisits = UIImage(named: "tabBarPin")
        myVisitsVC.tabBarItem = UITabBarItem(title: "Visits", image: imageVisits, selectedImage: selectedImageVisits)

        let mapVC = MapVC()
        let mapNC = UINavigationController(rootViewController: mapVC)
        let imageMap = UIImage(named: "map")
        let selectedImageMap = UIImage(named: "map")
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: imageMap, selectedImage: selectedImageMap)

      
        return [homeNC, myVisitsNC, mapNC, settingsNC]
    }
}
