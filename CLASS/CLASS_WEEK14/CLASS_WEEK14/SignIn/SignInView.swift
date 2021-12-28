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
    let signInButton = UIButton() //로그인 버튼
    let signUpButton = UIButton() //회원가입 버튼
    
    
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
        usernameTextField.placeholder = "아이디를 입력해주세요"
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        
        addSubview(signInButton)
        signInButton.backgroundColor = .systemBlue
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor( .white, for: .normal)
        
        addSubview(signUpButton)
        signUpButton.backgroundColor = .clear
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.lightGray, for: .normal)
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
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    
}
