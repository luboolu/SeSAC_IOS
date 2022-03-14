//
//  DrinkWaterViewController.swift
//  SeSSAC_WATER
//
//  Created by 김진영 on 2021/10/08.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet var totalDrinkWaterInfoLabel: UILabel!
    @IBOutlet var totalDrinkWaterLabel: UILabel!
    @IBOutlet var achivementRateLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var drinkWaterTextField: UITextField!
    @IBOutlet var drinkWaterTextFieldml: UILabel!
    
    @IBOutlet var drinkWaterButton: UIButton!
    
    @IBOutlet var resetButton: UIBarButtonItem!
    @IBOutlet var profileButton: UIBarButtonItem!
    
    var water: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults 초기화
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
        
        //초기 레이블 값, 이미지 설정
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        mainImageView.image = UIImage(named: "1-1")
        
        totalDrinkWaterInfoLabel.textColor = .white
        totalDrinkWaterInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        totalDrinkWaterLabel.textColor = .white
        totalDrinkWaterLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        
        achivementRateLabel.textColor = .white
        achivementRateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        infoLabel.textColor = .white
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        drinkWaterTextField.textColor = .white
        drinkWaterTextField.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        
        drinkWaterTextFieldml.textColor = .white
        drinkWaterTextFieldml.font = UIFont.systemFont(ofSize: 30, weight: .regular)

        drinkWaterButton.backgroundColor = .white
        drinkWaterButton.setTitleColor(.black, for: .normal)

        resetButton.tintColor = .white
        
        profileButton.tintColor = .white
      
    }
    
    //왼쪽 상단의 reset button, 눌리면 마신 양을 초기화함
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        //1. totalDrinkWaterLabel 초기화
        water = 0
        totalDrinkWaterLabel.text = "\(water)ml"
        
        //2. achivementRateLabel 초기화
        achivementRateLabel.text = "목표의 0%"
        
        //3.drinkWaterTextField 초기화
        drinkWaterTextField.text = "\(0)"
        
        //4. mainImageview 초기화
        mainImageView.image = UIImage(named: "1-1")
        
        totalDrinkWaterLabel.textColor = .white
        totalDrinkWaterInfoLabel.textColor = .white
        achivementRateLabel.textColor = .white
    }
    
    //하단의 물마시기 버튼, 눌리면 text field에 입력된 값 만큼을 물 마신 양에 추가
    @IBAction func drinkWaterButtonClicked(_ sender: UIButton) {
        //0. 프로필이 입력되지 않은 상태로 버튼이 눌린다면, 프로필을 입력해달라는 alert 띄우기
        let recommand: Double = UserDefaults.standard.double(forKey: "recommand")

        if recommand == 0 {
            alertMaker(myTitle: "error!", myMessage: "프로필을 설정해주세요!", myAction: "네")
        } else {
            infoLabel.text = "\(UserDefaults.standard.string(forKey: "nickName")!)님의 하루 물 권장 섭취량은 \(recommand)L 입니다."
            //1. drinkWaterTextField에 입력된 물 양 가져오기
            let drinkWaterInput = drinkWaterTextField.text!
            
            if drinkWaterInput.count != 0 && drinkWaterInput.unicodeScalars.allSatisfy(CharacterSet.decimalDigits.contains){
                let drinkWater: Int = Int(drinkWaterInput)!
                
                if drinkWater != 0 {
                    //2. totalDrinkWaterLabel에 1.만큼 추가
                    water += drinkWater
                    totalDrinkWaterLabel.text = "\(water)ml"
                    
                    //3. achivementRateLabel에 변경된 2. 값 반영
                    let achive: Int = Int(((Double(water) / 1000) / recommand) * 100)
                    achivementRateLabel.text = "목표의 \(achive)%"
                    
                    if achive >= 100 {
                        totalDrinkWaterLabel.textColor = UIColor(named: "pinkTextColor")
                        totalDrinkWaterInfoLabel.textColor = UIColor(named: "pinkTextColor")
                        achivementRateLabel.textColor = UIColor(named: "pinkTextColor")
                    }
                    
                    //4. mainImageView 3.의 정도에 따라 이미지가 변경되도록 함
                    setMainImageWithAchive(a: achive)
                } else {
                    alertMaker(myTitle: "error!", myMessage: "마신 물의 양을 입력해주세요", myAction: "확인")
                }
                
            } else {
                drinkWaterTextField.text = "\(0)"
                alertMaker(myTitle: "error!", myMessage: "숫자로 입력해주세요", myAction: "확인")
            }
        }
        
        func setMainImageWithAchive(a:Int){
            let imageName: String
            
            if a >= 90 {
                imageName = "1-9"
            } else if a >= 80 {
                imageName = "1-8"
            } else if a >= 70 {
                imageName = "1-7"
            } else if a >= 60 {
                imageName = "1-6"
            } else if a >= 50 {
                imageName = "1-5"
            } else if a >= 40 {
                imageName = "1-4"
            } else if a >= 30 {
                imageName = "1-3"
            } else if a >= 20 {
                imageName = "1-2"
            } else {
                imageName = "1-1"
            }
            
            mainImageView.image = UIImage(named: imageName)
        }
        
        
    }
    
    func alertMaker(myTitle: String, myMessage: String, myAction: String) {
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .actionSheet)
        //2. UIAlertAction 생성: 버튼들을...
        let ok = UIAlertAction(title: myAction, style: .default)
        //3. 1 + 2
        alert.addAction(ok)
        //4. present
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        //탭 제스쳐 인식 후, 키보드가 내리기
        view.endEditing(true)
    }

}
