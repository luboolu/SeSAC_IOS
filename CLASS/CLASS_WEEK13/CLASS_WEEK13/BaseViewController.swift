//
//  BaseViewController.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/22.
//

import UIKit

import SnapKit


//뷰컨트롤러를 만들때마다 중복되는 코드들을 여기서 미리 만들어두고 상속시키면 편함!
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }
    
}
