//
//  KoficAPIManager.swift
//  SeSAC_KOFICMOVIE
//
//  Created by 김진영 on 2021/11/02.
//

import Foundation


import Foundation
import SwiftyJSON
import Alamofire

class KoficAPIManager {
    static let shared = KoficAPIManager()
    
    func fetchBoxofficeData(date: String, result: @escaping (Int, JSON) -> ()) {
        
        //TMDB로부터 Trend Data 받아오기
        var queryString = URLComponents(string: Endpoint.KoficDailyBoxOfficeURL)
        let queryApiKey = URLQueryItem(name: "key", value: APIKEY.KOFIC)
        let queryDate = URLQueryItem(name: "targetDt", value: date)

        
        queryString?.queryItems = [queryApiKey, queryDate]
        
        print(queryString as! URLConvertible)

        AF.request(queryString as! URLConvertible, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
