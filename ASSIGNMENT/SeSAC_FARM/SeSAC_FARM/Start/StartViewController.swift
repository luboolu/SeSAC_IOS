//
//  StartViewController.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    let mainView = StartView()
    
    override func loadView() {
        super.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonClicked() {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
}
