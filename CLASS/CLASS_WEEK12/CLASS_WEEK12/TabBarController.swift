//
//  TabBarController.swift
//  CLASS_WEEK12
//
//  Created by 김진영 on 2021/12/15.
//

import UIKit

//navigationController, TabBarController
//TabBar, TabBarItem(title, image, selectImage, tintColor)
//iOS13: UITabBarAppearence 생성 (버전에 따른 분기 처리 필요)
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBar.delegate = self
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "pencil")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "pencil.fill")
        
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        
        
        let thirdVC = DetailViewController()
        thirdVC.title = "타이틀"
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstVC,secondVC,thirdNav], animated: true)
        
        let appearence = UITabBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = .white
        
        
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(#function)
    }
    
}
