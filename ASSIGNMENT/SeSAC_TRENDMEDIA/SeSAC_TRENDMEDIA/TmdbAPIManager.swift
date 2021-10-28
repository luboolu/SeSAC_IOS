//
//  TmdbAPIManager.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/28.
//

import Foundation
import SwiftyJSON
import Alamofire

class TmdbAPIManager {
    static let shared = TmdbAPIManager()
    
    func fetchTrendData(startPage: Int, result: @escaping (Int, JSON) -> ()) {
        
        //TMDB로부터 Trend Data 받아오기
        var queryString = URLComponents(string: Endpoint.tmdbTrendURL)
        let queryApiKey = URLQueryItem(name: "api_key", value: APIKEY.TMDB)
        let queryMediaType = URLQueryItem(name: "media_type", value: "movie")
        let qeuryStartPage = URLQueryItem(name: "page", value: String(startPage))
        
        queryString?.queryItems = [queryApiKey, queryMediaType, qeuryStartPage]
        
        //print(queryString as! URLConvertible)

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
