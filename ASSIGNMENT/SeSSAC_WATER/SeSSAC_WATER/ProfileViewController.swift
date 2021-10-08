//
//  ProfileViewController.swift
//  SeSSAC_WATER
//
//  Created by 김진영 on 2021/10/08.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        //textfield에 입력된 값들이 정확한지 확인하고 싶음
        //nickname은 String, height weight는 int인지 확인하고, 맞다면 userdefault에 저장하고 아니라면 textfield에 빨간색으로 틀렸다고 표시
        if nickNameTextField.text != nil && heightTextField.text != nil && weightTextField.text != nil {
            
            var nickName = nickNameTextField.text!
            var height = heightTextField.text!
            var weight = weightTextField.text!
            
            print(type(of: nickName))
            print(type(of: height))
            print(type(of: weight))
            
        }
        
        
        

            
        
        
        UserDefaults.standard.set(nickNameTextField.text, forKey: "nickName")
        UserDefaults.standard.set(heightTextField.text, forKey: "height")
        UserDefaults.standard.set(weightTextField.text, forKey: "weight")
        
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        let height = UserDefaults.standard.integer(forKey: "height")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        
        print("\(nickName)님은 \(height)cm이고 \(weight)kg입니다.")
        
        
    }
    
}
