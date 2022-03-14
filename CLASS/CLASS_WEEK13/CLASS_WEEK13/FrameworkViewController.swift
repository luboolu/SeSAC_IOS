//
//  FrameworkViewController.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/23.
//

import Foundation
import CLASS_WEEK13_FRAMEWORK
import UIKit

class FrameworkViewcontroller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sesac = SeSACOpen()
        sesac.presentWebViewController(url: "https://www.naver.com", transitionStyle: .push, vc: self)
    }
}
