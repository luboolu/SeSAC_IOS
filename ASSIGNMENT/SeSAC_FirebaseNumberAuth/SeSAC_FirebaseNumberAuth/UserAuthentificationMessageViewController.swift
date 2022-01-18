//
//  UserAuthentificationMessageViewController.swift
//  SeSAC_Friends
//
//  Created by 김진영 on 2022/01/17.
//

import Foundation
import UIKit

import SnapKit
import FirebaseAuth

class UserAuthentificationMessageViewController: UIViewController {
    
    private var authCode: String?
    
    let phoneNumberTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "핸드폰 번호"
        textfield.backgroundColor = .white
        textfield.clipsToBounds = true
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    let authCodeTextField: UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "인증번호"
        textfield.backgroundColor = .white
        textfield.clipsToBounds = true
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    let sendAuthCodeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("보내기", for: .normal)
        button.backgroundColor = .systemBlue
        
        
        return button
    }()
    
    let authButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("인증", for: .normal)
        button.backgroundColor = .systemBlue

        
        return button
    }()
    
    override func viewDidLoad() {
        setUpView()
        setConstraints()
        
        sendAuthCodeButton.addTarget(self, action: #selector(sendAuthCodeButtonClicked), for: .touchUpInside)
        authButton.addTarget(self, action: #selector(authButtonClicked), for: .touchUpInside)
    }
    
    func setUpView() {
        view.backgroundColor = .white
        
        view.addSubview(phoneNumberTextField)
        view.addSubview(sendAuthCodeButton)
        view.addSubview(authCodeTextField)
        view.addSubview(authButton)
    }
    
    func setConstraints() {
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        
        sendAuthCodeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(phoneNumberTextField.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
            make.width.equalTo(66)
        }
        
        authCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        authButton.snp.makeConstraints { make in
            make.top.equalTo(authCodeTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
    }
    
    @objc func sendAuthCodeButtonClicked() {
        print(phoneNumberTextField.text!)
        
        let number = phoneNumberTextField.text ?? ""
        
        //Auth.auth().languageCode = "kr";
        //인증번호를 보내줘야함!
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
                if error == nil {
                    //self.view.showMessagePrompt(error.localizedDescription)
                    self.authCode = verificationID
                    print("authCode: \(self.authCode)")
                } else {
                    print("Phone Verification Error")
                }
                
          }
    }
    
    @objc func authButtonClicked() {
        let inputCode = authCodeTextField.text ?? ""
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: authCode ?? "", verificationCode: inputCode)
        
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                print(success ?? "")
                print("인증 성공!!")
                
                let alert = UIAlertController(title: "성공", message: "휴대폰 인증에 성공했습니다!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)

                alert.addAction(ok)

                self.present(alert, animated: true, completion: nil)
                
            } else {
                print("인증 실패!!")
                
                let alert = UIAlertController(title: "실패", message: "인증코드가 틀렸습니다!", preferredStyle: .actionSheet)
                let ok = UIAlertAction(title: "확인", style: .default)

                alert.addAction(ok)

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
