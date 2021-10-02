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
    //Switch
    @IBOutlet var hideTextFieldSwitch: UISwitch!
    
    //회원정보
    var emailNum: String?
    var password: String?
    var nickname: String?
    var location: String?
    var recomandCode: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        //TextField 설정
        emailNumTextField.backgroundColor = .darkGray
        emailNumTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [.foregroundColor: UIColor.white])
        emailNumTextField.keyboardType = .emailAddress
        emailNumTextField.textAlignment = .center
        emailNumTextField.borderStyle = .roundedRect
        
        passwordTextField.backgroundColor = .darkGray
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.white])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .center
        passwordTextField.borderStyle = .roundedRect
        
        nickNameTextField.backgroundColor = .darkGray
        nickNameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.white])
        nickNameTextField.textAlignment = .center
        nickNameTextField.borderStyle = .roundedRect
        
        locationTextField.backgroundColor = .darkGray
        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor: UIColor.white])
        locationTextField.textAlignment = .center
        locationTextField.borderStyle = .roundedRect
        
        recomandCodeTextField.backgroundColor = .darkGray
        recomandCodeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [.foregroundColor: UIColor.white])
        recomandCodeTextField.keyboardType = .numberPad
        recomandCodeTextField.textAlignment = .center
        recomandCodeTextField.borderStyle = .roundedRect
        
        
        //signUpButton 설정
        signUpButton.backgroundColor = .white
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.cornerRadius = 10

        addInfoButton.contentHorizontalAlignment = .left
        
        hideTextFieldSwitch.onTintColor = .red
        hideTextFieldSwitch.thumbTintColor = .white
        

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        //키보드 내리기!
        view.endEditing(true)
    }
    
    @IBAction func hideTextFieldSwitchOn(_ sender: UISwitch) {
        //3개의 textfield를 숨겼다가 보여줌
        
        if hideTextFieldSwitch.isOn {
            nickNameTextField.isHidden = false
            locationTextField.isHidden = false
            recomandCodeTextField.isHidden = false
        } else {
            nickNameTextField.isHidden = true
            locationTextField.isHidden = true
            recomandCodeTextField.isHidden = true
        }
    }
    
    @IBAction func signUpButtonClick(_ sender: UIButton) {
        //회원가입 버튼을 누르면 입력된 회원 정보를 출력!
        print("회원가입 정보 확인")
        
        if emailNum != nil{
            print("ID: \(emailNum!)")
        }
        
        if password != nil {
            print("PW: \(password!)")
        }
        
        if nickname != nil {
            print("NICK: \(nickname!)")
        }
        
        if location != nil {
            print("LOCATION: \(location!)")
        }
        
        if recomandCode != nil {
            print("CODE: \(recomandCode!)")
        }
        
        
    }
    
    @IBAction func emailNumTextFieldInput(_ sender: UITextField) {
        emailNum = emailNumTextField.text
    }
    
    @IBAction func passwordTextFieldInput(_ sender: UITextField) {
        password = passwordTextField.text
    }
    
    
    @IBAction func nickNameTextFieldInput(_ sender: UITextField) {
        nickname = nickNameTextField.text
    }
    
    @IBAction func loacationTextFieldInput(_ sender: UITextField) {
        location = locationTextField.text
    }
    
    
    @IBAction func recomandCodeTextFieldInput(_ sender: UITextField) {
        recomandCode = recomandCodeTextField.text
    }
    
    
    

}
