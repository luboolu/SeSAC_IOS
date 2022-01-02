//
//  SignUpViewController.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    let mainView = SignUpView()
    var viewModel = SignUpViewModel()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "새싹농장 가입하기"

        
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordConfirmTextField.addTarget(self, action: #selector(passwordConfirmTextFieldDidChange(_:)), for: .editingChanged)
        
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
    }
    

    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
        
        if viewModel.email.value != "" && viewModel.nickname.value != "" && viewModel.password.value != "" && viewModel.passwordConfirm.value != "" {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor(named: "sesac_green")
                self.mainView.signUpButton.setTitle("시작하기", for: .normal)
                self.mainView.signUpButton.isEnabled = true
            }
        } else {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor.lightGray
                self.mainView.signUpButton.setTitle("가입하기", for: .normal)
                self.mainView.signUpButton.isEnabled = false
            }
        }
    }
    
    @objc func nicknameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.nickname.value = textfield.text ?? ""
        
        if viewModel.email.value != "" && viewModel.nickname.value != "" && viewModel.password.value != "" && viewModel.passwordConfirm.value != "" {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor(named: "sesac_green")
                self.mainView.signUpButton.setTitle("시작하기", for: .normal)
                self.mainView.signUpButton.isEnabled = true
            }
        } else {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor.lightGray
                self.mainView.signUpButton.setTitle("가입하기", for: .normal)
                self.mainView.signUpButton.isEnabled = false
            }
        }

    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        
        if viewModel.email.value != "" && viewModel.nickname.value != "" && viewModel.password.value != "" && viewModel.passwordConfirm.value != "" {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor(named: "sesac_green")
                self.mainView.signUpButton.setTitle("시작하기", for: .normal)
                self.mainView.signUpButton.isEnabled = true
            }
        } else {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor.lightGray
                self.mainView.signUpButton.setTitle("가입하기", for: .normal)
                self.mainView.signUpButton.isEnabled = false
            }
        }

    }
    
    @objc func passwordConfirmTextFieldDidChange(_ textfield: UITextField) {
        viewModel.passwordConfirm.value = textfield.text ?? ""
        
        if viewModel.email.value != "" && viewModel.nickname.value != "" && viewModel.password.value != "" && viewModel.passwordConfirm.value != "" {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor(named: "sesac_green")
                self.mainView.signUpButton.setTitle("시작하기", for: .normal)
                self.mainView.signUpButton.isEnabled = true
            }
        } else {
            DispatchQueue.main.async {
                self.mainView.signUpButton.backgroundColor = UIColor.lightGray
                self.mainView.signUpButton.setTitle("가입하기", for: .normal)
                self.mainView.signUpButton.isEnabled = false
            }
        }

    }
    
    @objc func signUpButtonClicked() {
        print(#function)
        viewModel.signUp {
            print("completion")
        }
    }
    
    

    
}
