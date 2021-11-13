//
//  MemoTutorialViewController.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/12.
//

import UIKit

class MemoTutorialViewController: UIViewController {
    
    static let identifier = "MemoTutorialViewController"

    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialView.clipsToBounds = true
        tutorialView.layer.cornerRadius = 10
        
        okButton.clipsToBounds = true
        okButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func okButtonClicked(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: "isFirst")
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
