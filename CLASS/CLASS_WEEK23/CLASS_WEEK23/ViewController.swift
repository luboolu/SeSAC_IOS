//
//  ViewController.swift
//  CLASS_WEEK23
//
//  Created by 김진영 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func calculateTextFieldTextCount() -> Int {
        return firstTextField.text?.count ?? 0
    }

    @IBAction func firstButtonClicked(_ sender: UIButton) {
        firstLabel.text = firstTextField.text
    }
}

