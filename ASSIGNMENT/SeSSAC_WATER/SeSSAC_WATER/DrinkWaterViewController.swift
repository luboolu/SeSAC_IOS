//
//  DrinkWaterViewController.swift
//  SeSSAC_WATER
//
//  Created by 김진영 on 2021/10/08.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet var totalDrinkWaterLabel: UILabel!
    @IBOutlet var achivementRateLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var drinkWaterTextField: UITextField!
    
    var water: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults 초기화
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
        
        //초기 레이블 값, 이미지 설정
        mainImageView.image = UIImage(named: "1-1")
        
    }
    
    //왼쪽 상단의 reset button, 눌리면 마신 양을 초기화함
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        //1. totalDrinkWaterLabel 초기화
        water = 0
        totalDrinkWaterLabel.text = "\(water)ml"
        //2. achivementRateLabel 초기화
        achivementRateLabel.text = "목표의 0%"
        //3. mainImageview 초기화
        mainImageView.image = UIImage(named: "1-1")
    }
    
    //하단의 물마시기 버튼, 눌리면 text field에 입력된 값 만큼을 물 마신 양에 추가
    @IBAction func drinkWaterButtonClicked(_ sender: UIButton) {
        //0. 프로필이 입력되지 않은 상태로 버튼이 눌린다면, 프로필을 입력해달라는 alert 띄우기
        let recommand: Double = UserDefaults.standard.double(forKey: "recommand") ?? 0
        print(recommand)
        if recommand == 0 {
            print("프로필이 입력되지 않았습니다!")
        } else {
            infoLabel.text = "\(UserDefaults.standard.string(forKey: "nickName")!)님의 하루 물 권장 섭취량은 \(recommand)L 입니다."
            //1. drinkWaterTextField에 입력된 물 양 가져오기
            let drinkWaterInput = drinkWaterTextField.text!
            
            if drinkWaterInput.count != 0 && drinkWaterInput.unicodeScalars.allSatisfy(CharacterSet.decimalDigits.contains){
                let drinkWater: Int = Int(drinkWaterInput)!
                
                //2. totalDrinkWaterLabel에 1.만큼 추가
                water += drinkWater
                totalDrinkWaterLabel.text = "\(water)ml"
                
                //3. achivementRateLabel에 변경된 2. 값 반영
                let achive: Int = Int(((Double(water) / 1000) / recommand) * 100)
                achivementRateLabel.text = "목표의 \(achive)%"
                
                if achive >= 100 {
                    totalDrinkWaterLabel.textColor = .red
                }
                
                //4. mainImageView 3.의 정도에 따라 이미지가 변경되도록 함
                if achive >= 90 {
                    mainImageView.image = UIImage(named: "1-9")
                } else if achive >= 80 {
                    mainImageView.image = UIImage(named: "1-8")
                } else if achive >= 70 {
                    mainImageView.image = UIImage(named: "1-7")
                } else if achive >= 60 {
                    mainImageView.image = UIImage(named: "1-6")
                } else if achive >= 50 {
                    mainImageView.image = UIImage(named: "1-5")
                } else if achive >= 40 {
                    mainImageView.image = UIImage(named: "1-4")
                } else if achive >= 30 {
                    mainImageView.image = UIImage(named: "1-3")
                } else if achive >= 20 {
                    mainImageView.image = UIImage(named: "1-2")
                } else {
                    mainImageView.image = UIImage(named: "1-1")
                }
            }
        }
        
        
    }
    
    
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        //탭 제스쳐 인식 후, 키보드가 내리기
        view.endEditing(true)
    }
    
    
    
}
