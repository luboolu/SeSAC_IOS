//
//  LotteryViewController.swift
//  SeSAC_LOTTERY
//
//  Created by 김진영 on 2021/10/25.
//

import UIKit
import SwiftyJSON
import Alamofire

class LotteryViewController: UIViewController {

    @IBOutlet weak var roundTextField: UITextField!
    @IBOutlet weak var resultRoundLabel: UILabel!
    @IBOutlet weak var roundPickerView: UIPickerView!

    
    @IBOutlet weak var num1Label: UILabel!
    @IBOutlet weak var num2Label: UILabel!
    @IBOutlet weak var num3Label: UILabel!
    @IBOutlet weak var num4Label: UILabel!
    @IBOutlet weak var num5Label: UILabel!
    @IBOutlet weak var num6Label: UILabel!
    @IBOutlet weak var bonusNumLabel: UILabel!
    
    
    let pickList = Array(1...1006).sorted(by: >)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundPickerView.delegate = self
        roundPickerView.dataSource = self
        
        getLotteryInfo(round: 986)
        
        roundTextField.inputView = roundPickerView
        
    }
    
    func getLotteryInfo(round: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.num1Label.text = json["drwtNo1"].stringValue
                self.num2Label.text = json["drwtNo2"].stringValue
                self.num3Label.text = json["drwtNo3"].stringValue
                self.num4Label.text = json["drwtNo4"].stringValue
                self.num5Label.text = json["drwtNo5"].stringValue
                self.num6Label.text = json["drwtNo6"].stringValue
                self.bonusNumLabel.text = json["bnusNo"].stringValue
                
                
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }


}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //pickerView의 row가 선택되었을때!
        //API로부터 정보를 받아와야 한다.
        roundTextField.text = String(pickList[row])
        resultRoundLabel.text = "\(pickList[row])회 당첨결과"
        getLotteryInfo(round: pickList[row])
        
    }
    
    
    
}
