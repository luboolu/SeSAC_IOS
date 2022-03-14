//
//  TabBarController.swift
//  SeSAC_CarrotMarket
//
//  Created by 김진영 on 2021/12/15.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBar.delegate = self
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "홈"
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let townVC = TownViewController()
        townVC.tabBarItem.title = "동네생활"
        townVC.tabBarItem.image = UIImage(systemName: "newspaper")
        townVC.tabBarItem.selectedImage = UIImage(systemName: "newspaper")
        let townNav = UINavigationController(rootViewController: townVC)
        
        let nearVC = MyNearViewController()
        nearVC.tabBarItem.title = "내 근처"
        nearVC.tabBarItem.image = UIImage(systemName: "location.north")
        nearVC.tabBarItem.selectedImage = UIImage(systemName: "location.north")
        let nearNav = UINavigationController(rootViewController: nearVC)
        
        let chatVC = ChattingViewController()
        chatVC.tabBarItem.title = "채팅"
        chatVC.tabBarItem.image = UIImage(systemName: "message")
        chatVC.tabBarItem.selectedImage = UIImage(systemName: "message")
        let chatNav = UINavigationController(rootViewController: chatVC)
        
        let myCarrotVC = MyCarrotViewController()
        myCarrotVC.tabBarItem.title = "나의 당근"
        myCarrotVC.tabBarItem.image = UIImage(systemName: "person")
        myCarrotVC.tabBarItem.selectedImage = UIImage(systemName: "person")
        let myCarrotNav = UINavigationController(rootViewController: myCarrotVC)
        
        
        
        setViewControllers([homeNav, townNav, nearNav, chatNav, myCarrotNav], animated: true)
        
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
