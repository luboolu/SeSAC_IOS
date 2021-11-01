//
//  HomeViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

//        for family in UIFont.familyNames {
//            print(family)
//
//            for sub in UIFont.fontNames(forFamilyName: family) {
//                print("=========== \(sub)")
//            }
//
//        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        print(#function)
        
        //1.스토리보드 특정
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        //2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: AddViewController.identifier) as! AddViewController
        
        //2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        //nav.modalTransitionStyle = .partialCurl// full screen일때만 된다고 앱이 꺼진다!
        
        //3. present 방식으로 화면 전환
        self.present(nav, animated: true, completion: nil)
        
    }
    
}
