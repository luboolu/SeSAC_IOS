//
//  FoodViewController.swift
//  CLASS_211001
//
//  Created by 김진영 on 2021/10/01.
//

import UIKit

class FoodViewController: UIViewController {

    @IBOutlet var userSearchTextField: UITextField!
    @IBOutlet var foodButton1: UIButton!
    @IBOutlet var foodButton2: UIButton!
    @IBOutlet var foodButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonUISetiing(foodButton1, "사탕")
        buttonUISetiing(foodButton2, "초콜릿")
        buttonUISetiing(foodButton3, "츄러스")
    }
    
    //buttonoutletName: 외부 매개변수(parameter), btn: 내부 매개변수, UIButton: 전달인자(Argument)
    //_ : 외부 매개변수 이름 생략 가능 -> 와일드 카드 식별자 --> 와일드 카드 패턴!
    func buttonUISetiing(_ btn: UIButton, _ title: String = "사탕") {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
    }
    
    //didEndOnExit
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        //키보드가 내리기
        view.endEditing(true)
    
    }
    
    @IBAction func foodTagButtonClicked(_ sender: UIButton) {
        //버튼에 이미지만 들어있다면, 타이틀이 없기 때문에 nil이 나올 수 있다
        userSearchTextField.text = sender.currentTitle
    }
}
