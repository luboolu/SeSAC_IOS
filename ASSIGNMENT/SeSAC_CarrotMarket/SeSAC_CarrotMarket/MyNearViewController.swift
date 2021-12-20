//
//  MyNearViewController.swift
//  SeSAC_CarrotMarket
//
//  Created by 김진영 on 2021/12/15.
//

import UIKit

class MyNearViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.topItem?.title = "내 근처"
    }
}
