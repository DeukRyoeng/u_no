//
//  TabbarController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/4/24.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    private func setupTabbar() {
        
        let first = MainViewController()
        let second = SearchViewController()
        let third = FavoritesController()
        
        let settingController = SettingController()
        let settingNavController = UINavigationController(rootViewController: settingController)
        
        first.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        second.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        third.tabBarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "bookmark.fill"), tag: 2)
        settingNavController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.fill"), tag: 3)
        
        viewControllers = [first, second, third, settingNavController]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 111/255, green: 230/255, blue: 102/255, alpha: 1)
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = false
        
        selectedIndex = 0
    }
}
