//
//  ViewController.swift
//  CLASS_WEEK4_LAYOUT
//
//  Created by 김진영 on 2021/10/22.
//

import UIKit

/*
 Button Device 수평 수직 중앙을 가장 먼저 설정
 button, label등 컨텐츠 크기에 영향을 받는다.
 
 1. 사용자의 디바이스가 무엇인지 알기 위해서,,width, height를 알아낸다.
 2, device property
 3. device library
 */

class ViewController: UIViewController {

    @IBOutlet weak var containerViewHeight: NSLayoutConstraint! //NS = NextStep(스티브잡스 옛날 회사)
    var heightStatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if UIScreen.main.bounds.width < 375 {
            
        }
    }

    @IBAction func blackButtonClicked(_ sender: UIButton) {
        print(#function)
        heightStatus = !heightStatus
        containerViewHeight.constant = heightStatus ? UIScreen.main.bounds.height * 0.2 : 50
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
            
    }
    
}

