//
//  ViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var backupLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        /*
         S-Core Dream
         =========== S-CoreDream-2ExtraLight
         =========== S-CoreDream-5Medium
         =========== S-CoreDream-8Heavy
         */
//
//        for family in UIFont.familyNames {
//            print(family)
//
//            for sub in UIFont.fontNames(forFamilyName: family) {
//                print("=========== \(sub)")
//            }
//
//        }
        
        welcomeLabel.text = NSLocalizedString("welcome_text", comment: "")
//        welcomeLabel.text = LocalizableStrings.welcome_text.rawValue.localized()
//        welcomeLabel.font = UIFont(name: "S-CoreDream-8Heavy", size: 14)
        welcomeLabel.font = UIFont().mainBlack
        
  
        backupLabel.text = NSLocalizedString("data_backup", comment: "")
//        backupLabel.text = NSLocalizedString("data_backup", tableName: "Setting", bundle: .main, value: "", comment: "")
        
        //backupLabel.text = LocalizableStrings.data_backup.rawValue.localized()
        backupLabel.font = UIFont().mainBlack
        
    }


}

