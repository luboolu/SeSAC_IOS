//
//  SignInView.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import UIKit
import SnapKit

class SignInView: UIView, ViewRepresentable {

    var identifierTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "아이디"
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
    
    
    var signInButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("로그인", for: .normal)
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

        addSubview(identifierTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
    }
    
    func setupConstraints() {
        identifierTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(identifierTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
    }
    
}
