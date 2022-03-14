//
//  LedBoardViewController.swift
//  SSAC_LEDBOARD
//
//  Created by 김진영 on 2021/10/04.
//

import UIKit

class LedBoardViewController: UIViewController {

    
    @IBOutlet var inputLedBoardText: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var colorChangeButton: UIButton!

    @IBOutlet var LedBoardText: UILabel!
    
    
    @IBOutlet var UIGestureRecognizer: UITapGestureRecognizer!
    

    @IBOutlet var boardView: UIView!
    
    
    let textColor: [UIColor] = [.white, .red, .orange, .yellow, .green, .blue ,.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //text field의 글자가 모두 보이는지 확인하고, 보이지 않는다면 글자의 크기를 조정하여 모두 보이게 함
        if LedBoardText.adjustsFontSizeToFitWidth == false {
            LedBoardText.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    //send 버튼이 클릭되면 text field의 내용을 전광판에 띄움
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        LedBoardText.text = inputLedBoardText.text
    }
    
    //color change 버튼이 눌리면 text field 글자의 색을 랜덤으로 바꿈
    @IBAction func colorChangeButtonClicked(_ sender: UIButton) {
        LedBoardText.textColor = textColor[Int.random(in: 0...(textColor.count - 1))] 
    }
    

    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        //tap gesture를 이용하여 키보드 내리기!
        view.endEditing(true)
        
        //tap gesture가 인식되었을때, boardView가 보여진 상태라면 숨기고, 숨겨진 상태라면 다시 보이게 함
        if boardView.isHidden == true{
            boardView.isHidden = false
        } else {
            boardView.isHidden = true
        }
            
        
    }
    
    
}
