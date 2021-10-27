//
//  TranslationViewController.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/26.
//

import UIKit
import SwiftyJSON
import Alamofire

class TranslationViewController: UIViewController {
    
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    
    var translateText: String = "" {
        didSet {
            outputTextView.text = translateText
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        TranslatedAPIManager.shared.fetchTranslateData(text: inputTextView.text!) { code, json in
            
            
            switch code {
            case 200:
                print("성공")
                self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print("실패")
                self.translateText = json["errorMessage"].stringValue
            default:
                print("오류")
            }
            
        }
            //result() closure 부분

        
//        //1.
//        if let value = inputTextView.text {
//            TranslatedAPIManager.shared.fetchTranslateData(text: value)
//        }
//
//        //2.
//        guard let text = inputTextView.text else {
//            return
//        }
        

        
        
    }
}
