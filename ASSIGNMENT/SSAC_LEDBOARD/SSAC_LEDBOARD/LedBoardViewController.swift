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
    
    
    let textColor: [UIColor] = [.white, .red, .orange, .yellow, .green, .blue ,.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        LedBoardText.text = inputLedBoardText.text

    }
    
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        //키보드가 내리기
        view.endEditing(true)
    
    }
    
    @IBAction func colorChangeButtonClicked(_ sender: UIButton) {
        LedBoardText.textColor = textColor[Int.random(in: 0...(textColor.count - 1))] 
    }
    
    
    
}
