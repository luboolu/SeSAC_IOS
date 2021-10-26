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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "uesxBpa4kC9tztddyWGr",
            "X-Naver-Client-Secret": "GRMNLkQCNF"
        ]
        
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": inputTextView.text!
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.outputTextView.text = "\(json["message"]["result"]["translatedText"])"
                

                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}
