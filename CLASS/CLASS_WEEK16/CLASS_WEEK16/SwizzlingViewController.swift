//
//  SwizzlingViewController.swift
//  CLASS_WEEK16
//
//  Created by 김진영 on 2022/01/10.
//

import Foundation
import UIKit

class SwizzlingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view will appear")
        
    }
}

extension UIViewController {
    class func swizzlingMethod() {
        
        let origin = #selector(viewWillAppear(_:))
        let change = #selector(changeViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류")
            return
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
        
    }
            
    //Analytics
            @objc func changeViewWillAppear() {
                print(#function) 
            }
}
