//
//  SecondTabViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by jack on 2021/10/06.
//

import UIKit
import TextFieldEffects

class SecondTabViewController: UIViewController {
    //연결안됨
    @IBOutlet var mottoTextField: HoshiTextField!
    
    //연결안됨, 출첵1 - 몇 번 출첵했는지 보여줄 레이블
    @IBOutlet var numberLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //출첵
        let number = UserDefaults.standard.integer(forKey: "number")
        numberLable.text = "\(number)"
        
        
        print(self, #function)
        //3. UserDefaults에 저장되어 있는 값 가져오기
        let userMotto = UserDefaults.standard.string(forKey: "userMotto")
        print(userMotto)
        //4. 값을 표현하고자 하는 뷰 객체(텍스트 필드)에 보여주기
        mottoTextField.text = userMotto
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self, #function)
    }
    
    //연결안됨
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        //1.저장하고자 하는 데이터를 가져오기
        let userText = mottoTextField.text ?? "열심히 살자"
        //2. 데이터가 확인되었다면, UserDfaults에 key를 만들고, key에 데이터를 저장합니다.
        UserDefaults.standard.set(userText, forKey: "userMotto")
    }
    
    //출첵2 - 출석체크 버튼 누를 때의 기능
    //10번 출첵 -> 3번 버튼 누르면 13번 저장
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        //test. 랜덤 숫자 저장
        let number = Int.random(in: 1...100)
        
        //let number = UserDefaults.standard.integer(forKey: "number")
        
        UserDefaults.standard.set(number, forKey: "number")
        //UserDefaults.standard.set(number + 1, forKey: "number")
        
        //c 
    
        
    }
    
}
