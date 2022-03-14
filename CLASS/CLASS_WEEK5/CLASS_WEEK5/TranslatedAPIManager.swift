//
//  TranslatedAPIManager.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire

class TranslatedAPIManager {
    
    static let shared = TranslatedAPIManager()
    
    //typealias Comple
    
    func fetchTranslateData(text: String, result: @escaping (Int, JSON) -> () ) {
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET
        ]
        
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        //validate: 몇번대부터 몇번대 까지의 상태 코드를 성공이라고 할지 정함
        //1. 상태 코드: 200...500
        //2. 상태 코드 분기
        AF.request(Endpoint.translateURL, method: .post, parameters: parameters, headers: header ).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
                
                //self.outputTextView.text = "\(json["message"]["result"]["translatedText"])"
                

                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
