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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //왼쪽 상단의 reset button, 눌리면 마신 양을 초기화함
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        //1. totalDrinkWaterLabel 초기화
        //2. achivementRateLabel 초기화
    }
    
    //하단의 물마시기 버튼, 눌리면 text field에 입력된 값 만큼을 물 마신 양에 추가
    @IBAction func drinkWaterButtonClicked(_ sender: UIButton) {
        //1. drinkWaterTextField에 입력된 물 양 가져오기
        //2. totalDrinkWaterLabel에 1.만큼 추가
        //3. achivementRateLabel에 변경된 2. 값 반영
        //4. mainImageView 3.의 정도에 따라 이미지가 변경되도록 함
        
        //+5. 프로필이 입력되지 않은 상태로 버튼이 눌린다면, 프로필을 입력해달라는 alert 띄우기
    }
    
    
}
