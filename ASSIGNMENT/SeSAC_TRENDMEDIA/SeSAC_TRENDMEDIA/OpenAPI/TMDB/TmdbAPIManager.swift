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
    
    func fetchGetCreditData(ID: Int, result: @escaping (Int, JSON) -> () ) {
        //TMDB로부터 movie의 Credit 정보를 받아오기
        //https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=<<api_key>>&language=en-US
        var queryString = URLComponents(string: "\(Endpoint.tmdbGetCredits)\(ID)/credits")
        let queryApiKey = URLQueryItem(name: "api_key", value: APIKEY.TMDB)
        let queryLaguage = URLQueryItem(name: "language", value: "en-US")
        
        queryString?.queryItems = [queryApiKey, queryLaguage]

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
    
    func fetchCreditData(creditID: String, result: @escaping (Int, JSON) -> () ) {
        //TMDB로부터 credit id에 해당하는 인물의 작품 정보를 받아오기
        //https://api.themoviedb.org/3/credit/{credit_id}?api_key=<<api_key>>
        
        var queryString = URLComponents(string: "\(Endpoint.tmdbCredits)\(creditID)")
        let queryApiKey = URLQueryItem(name: "api_key", value: APIKEY.TMDB)
        
        queryString?.queryItems = [queryApiKey]

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
    
    func fetchVideoData(movieID: String, result: @escaping (Int, JSON) -> () ) {
        
        var queryString = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos")
        let queryApiKey = URLQueryItem(name: "api_key", value: APIKEY.TMDB)
        
        queryString?.queryItems = [queryApiKey]
        
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
