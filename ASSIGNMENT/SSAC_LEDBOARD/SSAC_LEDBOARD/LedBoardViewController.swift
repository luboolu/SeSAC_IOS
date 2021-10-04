//
//  LedBoardViewController.swift
//  SSAC_LEDBOARD
//
//  Created by 김진영 on 2021/10/04.
//

import UIKit

class LedBoardViewController: UIViewController {

    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var colorChangeButton: UIButton!

    @IBOutlet var LedBoardText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        LedBoardText.text = 
    }
    
}
