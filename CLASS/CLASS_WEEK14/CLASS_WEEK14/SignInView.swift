//
//  SignInView.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/27.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}

class SignInView: UIView, ViewRepresentable {
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        
        addSubview(signInButton)
        signInButton.backgroundColor = .systemBlue
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9) //디바이스 너비의 90%
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
    }
    
    
}
