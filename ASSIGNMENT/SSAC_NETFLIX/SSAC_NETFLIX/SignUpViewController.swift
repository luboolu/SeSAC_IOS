//
//  SignUpViewController.swift
//  SSAC_NETFLIX
//
//  Created by 김진영 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    //TextField
    @IBOutlet var emailNumTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var recomandCodeTextField: UITextField!
    //Button
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var addInfoButton: UIButton!
    
    @IBOutlet var hideTextFieldSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        //TextField 설정
        emailNumTextField.backgroundColor = .darkGray
        emailNumTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [.foregroundColor: UIColor.white])
        emailNumTextField.keyboardType = .emailAddress
        emailNumTextField.textAlignment = .center
        
        passwordTextField.backgroundColor = .darkGray
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.white])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .center
        
        nickNameTextField.backgroundColor = .darkGray
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.white])
        nickNameTextField.textAlignment = .center
        
        locationTextField.backgroundColor = .darkGray
        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor: UIColor.white])
        locationTextField.textAlignment = .center
        
        recomandCodeTextField.backgroundColor = .darkGray
        recomandCodeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [.foregroundColor: UIColor.white])
        recomandCodeTextField.keyboardType = .numberPad
        recomandCodeTextField.textAlignment = .center
        
        
        //signUpButton 설정
        signUpButton.backgroundColor = .white
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        
        addInfoButton.contentHorizontalAlignment = .left
        

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        //키보드 내리기!
        view.endEditing(true)
    }
    
    @IBAction func hideTextFieldSwitchOn(_ sender: UISwitch) {
        //3개의 textfield를 숨겼다가 보여줌
        print("switch on")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
