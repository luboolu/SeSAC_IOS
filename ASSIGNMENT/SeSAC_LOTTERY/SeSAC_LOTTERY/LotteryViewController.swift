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
    
    let pickList = Array(1...986)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundPickerView.delegate = self
        roundPickerView.dataSource = self
        
        roundTextField.inputView = roundPickerView
        
    }
    
    func getLotteryInfo(round: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + String(round)
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                print("JSON: \(json)")
                
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
        getLotteryInfo(round: pickList[row])
        
    }
    
    
    
}
