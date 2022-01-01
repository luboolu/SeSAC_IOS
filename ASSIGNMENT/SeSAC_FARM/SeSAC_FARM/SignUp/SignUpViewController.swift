//
//  SignUpViewController.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
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
        button.backgroundColor = UIColor(named: "sesac_green")
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.title = "새싹농장 가입하기"
        
        settingUI()
    }
    
    func settingUI() {
        view.addSubview(emailTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordConfirmTextField)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
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
