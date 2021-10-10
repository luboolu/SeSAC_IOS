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
                
                let waterRecommand: Double = (weight + height) / 100
                
                UserDefaults.standard.set(waterRecommand, forKey: "recommand")
                
                print("\(nickName)님은 \(height)cm이고 \(weight)kg입니다. 하루 권장 물 섭취량은 \(waterRecommand)L입니다.")
                
                //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
                //let alert = UIAlertController(title: "타이틀 테스트", message: "메시지가 입력되었습니다.", preferredStyle: .alert)
                let alert = UIAlertController(title: "", message: "프로필이 설정되었습니다", preferredStyle: .actionSheet)
                
                //2. UIAlertAction 생성: 버튼들을...
                let ok = UIAlertAction(title: "확인", style: .default)
                
                //3. 1 + 2
                alert.addAction(ok)
                
                //4. present
                present(alert, animated: true, completion: nil)
                
                
            } else {
                //heigt, weight에 숫자를 입력해달라고 표시
                print("숫자로 입력하세요!")
            }
        } else {
            //입력안한 textfield에 입력해달라고 표시
            print("입력하지 않은 칸이 있습니다!")
        }
   
    }
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        //탭 제스쳐 인식 후, 키보드가 내리기
        view.endEditing(true)
    }
}
