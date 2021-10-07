//
//  DDayViewController.swift
//  SSAC_EMOTIONDIARY
//
//  Created by 김진영 on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {

    
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 14.0, *){
            datePicker.preferredDatePickerStyle = .inline // 13.0 이하에선 동작하지 않음
        }
        
    }
    
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        
        print(datePicker.date)
        print(sender.date) //둘 다 동일한 형태의 결과가 나옴
        
        //DateFormatter: 원하는 형식으로 날짜를 표기할 수 있음
        //1. DateFormat 2. time zone에 맞춰 시간 조절 가능
        
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd" //21/10/20
        
        let value = format.string(from: sender.date)
        print(value)
        
        //100일 뒤 : TimeInterval 사용
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print(afterDate)
        
        
    }
    

}
