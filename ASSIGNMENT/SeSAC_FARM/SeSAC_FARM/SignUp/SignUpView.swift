//
//  SignUpView.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import UIKit
import SnapKit

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}

class SignUpView: UIView, ViewRepresentable {
    
    var emailTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "이메일 주소"
        textfield.backgroundColor = .white
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        
        return textfield
    }()
    
    var nicknameTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "닉네임"
        textfield.backgroundColor = .white
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        
        return textfield
    }()
    
    var passwordTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "비밀번호"
        textfield.backgroundColor = .white
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        
        return textfield
    }()
    
    var passwordConfirmTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "비밀번호 확인"
        textfield.backgroundColor = .white
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        
        return textfield
    }()
    
    var signUpButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("가입하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.backgroundColor = .white

        addSubview(emailTextField)
        addSubview(nicknameTextField)
        addSubview(passwordTextField)
        addSubview(passwordConfirmTextField)
        addSubview(signUpButton)
    }
    
    func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        passwordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordConfirmTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
    }
    
}
