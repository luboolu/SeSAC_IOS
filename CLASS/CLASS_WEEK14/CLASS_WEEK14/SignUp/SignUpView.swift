//
//  SignUpView.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/27.
//

import UIKit
import SnapKit


class SignUpView: UIView, ViewRepresentable {
    
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton()
    let signUpLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
 
    func setupView() {
        self.backgroundColor = .yellow
        
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "아이디를 입력해주세요"
        usernameTextField.clipsToBounds = true
        usernameTextField.layer.cornerRadius = 10
        
        addSubview(emailTextField)
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "이메일을 입력해주세요"
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 10
        
        addSubview(signUpButton)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 10
        
        addSubview(signUpLabel)
        signUpLabel.text = "회원가입"
        signUpLabel.textColor = .black
        signUpLabel.font = .boldSystemFont(ofSize: 25)
        signUpLabel.textAlignment = .center

        
    }
    
    func setupConstraints() {
        
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9) //디바이스 너비의 90%
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9) //디바이스 너비의 90%
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.bottom.equalTo(usernameTextField.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        

        
    }
    
}
