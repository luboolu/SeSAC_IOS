//
//  PostViewController.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import UIKit

class PostViewController: UIViewController {
    
    let mainView = PostView()
    var viewModel = PostViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
