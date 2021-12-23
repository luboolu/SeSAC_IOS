//
//  SingViewController.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/22.
//

import Foundation

class SignViewController: BaseViewController {
    
    var mainView = SignView()
    var viewModel = SignViewModel()
    
    //뷰컨트롤러의 루트뷰를 로드할때 호출되는 메서드
    //새로운 뷰를 반환하려고 할 때 사용
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupConstraints()
        
        viewModel.bind { text, color in
            self.mainView.passwordTextField.text = text
            self.mainView.passwordTextField.textColor = color
        }
    }
    
    override func configure() {
        //super.configure()
        
        mainView.emailTextField.placeholder = "이메일을 작성해주세요"
        mainView.signButton.addTarget(self, action: #selector(signButttonClicked), for: .touchUpInside)
        mainView.signButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    override func setupConstraints() {
        //super.setupConstraints()

    }
    
    @objc func signButttonClicked() {
        print(#function)
        
        guard let text = mainView.emailTextField.text else { return }
        viewModel.text = text
    }
    
}
