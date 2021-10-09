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
            
            let nickNameInput = nickNameTextField.text!
            let heightInput = heightTextField.text!
            let weightInput = weightTextField.text!
            
            if (nickNameInput.count != 0) && (heightInput.count != 0) && (weightInput.count != 0) {
                
                //height, weight가 숫자로 제대로 입력되었는지 확인
                if heightInput.unicodeScalars.allSatisfy(CharacterSet.decimalDigits.contains) && weightInput.unicodeScalars.allSatisfy(CharacterSet.decimalDigits.contains){

                    UserDefaults.standard.set(nickNameInput, forKey: "nickName")
                    UserDefaults.standard.set(Int(heightInput)!, forKey: "height")
                    UserDefaults.standard.set(Int(weightInput)!, forKey: "weight")
                    
                    let nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
                    let height: Double = UserDefaults.standard.double(forKey: "height")
                    let weight: Double = UserDefaults.standard.double(forKey: "weight")
                    
                    let water
                    
                    print("\(nickName)님은 \(height)cm이고 \(weight)kg입니다. 하루 권장 물 섭취량은 \((height + weight) / 100)L입니다.")
                    
                } else {
                    //heigt, weight에 숫자를 입력해달라고 표시
                    print("숫자로 입력하세요!")
                }
            } else {
                //입력안한 textfield에 입력해달라고 표시
                print("입력하지 않은 칸이 있습니다!")
            }
            
            
            
            
        }
        
        
        
        
    }
    
}
