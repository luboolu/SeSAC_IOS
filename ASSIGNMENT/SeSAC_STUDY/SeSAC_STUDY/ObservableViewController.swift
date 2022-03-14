//
//  ObservableViewController.swift
//  SeSAC_STUDY
//
//  Created by 김진영 on 2021/12/29.
//

import UIKit


class ObservableViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var idText: Observable<String> = Observable("")
    var passwordText: Observable<String> = Observable("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        idTextField.addTarget(self, action: #selector(idTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func idTextFieldDidChange(_ textfield: UITextField) {
        idText.value = idTextField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        passwordText.value = passwordTextField.text ?? ""
    }


}

