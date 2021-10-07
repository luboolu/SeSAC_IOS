//
//  DDayAssignmentViewController.swift
//  SSAC_EMOTIONDIARY
//
//  Created by 김진영 on 2021/10/07.
//

import UIKit

class DDayAssignmentViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var dDay100: UILabel!
    @IBOutlet var dDay200: UILabel!
    @IBOutlet var dDay300: UILabel!
    @IBOutlet var dDay400: UILabel!
    
    @IBOutlet var dDay100ImageView: UIView!
    @IBOutlet var dDay200ImageView: UIView!
    @IBOutlet var dDay300ImageView: UIView!
    @IBOutlet var dDay400ImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //text field의 글자가 모두 보이는지 확인하고, 보이지 않는다면 글자의 크기를 조정하여 모두 보이게 함
        if dDay100.adjustsFontSizeToFitWidth == false {
            dDay100.adjustsFontSizeToFitWidth = true
        }
        if dDay200.adjustsFontSizeToFitWidth == false {
            dDay200.adjustsFontSizeToFitWidth = true
        }
        if dDay300.adjustsFontSizeToFitWidth == false {
            dDay300.adjustsFontSizeToFitWidth = true
        }
        if dDay400.adjustsFontSizeToFitWidth == false {
            dDay400.adjustsFontSizeToFitWidth = true
        }
        
        //imageViewer의 가장자리를 둥글게 설정
        dDay100ImageView.layer.cornerRadius = 20
        dDay100ImageView.clipsToBounds = true
        
        dDay200ImageView.layer.cornerRadius = 20
        dDay200ImageView.clipsToBounds = true
        
        dDay300ImageView.layer.cornerRadius = 20
        dDay300ImageView.clipsToBounds = true
        
        dDay400ImageView.layer.cornerRadius = 20
        dDay400ImageView.clipsToBounds = true
        
        dDayInit()
    }
    
    //DatePicker가 눌렸을때 DDay Label을 기준에 맞게 재설정
    @IBAction func datePickerClicked(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let date100 = Date(timeInterval: 86400*100, since: sender.date)
        let date200 = Date(timeInterval: 86400*200, since: sender.date)
        let date300 = Date(timeInterval: 86400*300, since: sender.date)
        let date400 = Date(timeInterval: 86400*400, since: sender.date)
        
        dDay100.text = format.string(from: date100)
        dDay200.text = format.string(from: date200)
        dDay300.text = format.string(from: date300)
        dDay400.text = format.string(from: date400)
        
    }
    
    //DDay Label들을 현재 날짜 기준으로 설정
    func dDayInit(){
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let date100 = Date(timeInterval: 86400*100, since: Date())
        let date200 = Date(timeInterval: 86400*200, since: Date())
        let date300 = Date(timeInterval: 86400*300, since: Date())
        let date400 = Date(timeInterval: 86400*400, since: Date())
        
        dDay100.text = format.string(from: date100)
        dDay200.text = format.string(from: date200)
        dDay300.text = format.string(from: date300)
        dDay400.text = format.string(from: date400)
    }
    


}
