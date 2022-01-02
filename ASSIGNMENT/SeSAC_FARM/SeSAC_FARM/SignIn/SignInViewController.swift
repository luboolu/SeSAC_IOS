//
//  SignInViewController.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import UIKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    var viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "새싹농장 로그인"
        
        mainView.identifierTextField.addTarget(self, action: #selector(identifierTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func identifierTextFieldDidChange(_ textfield: UITextField) {
        viewModel.identifier.value = textfield.text ?? ""
        detectTextFieldFill()
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
        detectTextFieldFill()
    }
    
    @objc func signInButtonClicked() {
        print(#function)
        
        viewModel.signIn {
            print("complete!")
        }
    }
    
    func detectTextFieldFill() {
        if viewModel.identifier.value != "" && viewModel.password.value != "" {
            DispatchQueue.main.async {
                self.mainView.signInButton.backgroundColor = UIColor(named: "sesac_green")
                self.mainView.signInButton.isEnabled = true
            }
        } else {
            DispatchQueue.main.async {
                self.mainView.signInButton.backgroundColor = UIColor.lightGray
                self.mainView.signInButton.isEnabled = false
            }
        }
    }
}
