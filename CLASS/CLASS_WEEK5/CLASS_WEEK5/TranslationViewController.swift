//
//  TranslationViewController.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/26.
//

import UIKit
import Network

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
    
    let networkMonitor = NWPathMonitor() //네트워크 변경 감시자
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네트워크 변경 감지 클래스를 통해 사용자의 네트워크 상태가 변경될 때 마다 실행
        networkMonitor.pathUpdateHandler = { path in
            //클로져 구문
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("Cellular Wifi")
                } else {
                    print("Other")
                }
            } else {
                print("Network Disconnected")
            }
        }
        networkMonitor.start(queue: DispatchQueue.global())
        
    }
    
    

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        guard let text = inputTextView.text else { return }
        
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
