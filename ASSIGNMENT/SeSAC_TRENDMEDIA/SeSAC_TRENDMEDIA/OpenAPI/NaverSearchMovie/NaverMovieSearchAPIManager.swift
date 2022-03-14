//
//  NaverMovieSearchAPIManager.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire

class NaverMovieSearchAPIManager {
    static let shared = NaverMovieSearchAPIManager()
    
    func fetchMovieData(search: String, startPage: Int, result: @escaping (Int, JSON) -> () ) {
        
        //네이버 영화 API 호출하여 결과 debug 찍기
        //%형태로 인코딩 해주어야 함
        if let searchSource = "\(search)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            //let surl = "https://openapi.naver.com/v1/search/movie.json?query=\(searchSource)&display=10&start=\(startPage)"
            
            let url = Endpoint.NaverMovieSearchURL
            
            var queryString = URLComponents(string: url)
            let querySource = URLQueryItem(name: "query", value: String(searchSource))
            let queryStartPage = URLQueryItem(name: "start", value: String(startPage))
            
            queryString?.queryItems = [querySource, queryStartPage]
            
            print(queryString as! URLConvertible)
            let header: HTTPHeaders = [
                "X-Naver-Client-Id" : APIKEY.NAVER_ID,
                "X-Naver-Client-Secret" : APIKEY.NAVER_SECRETE
            ]
            
            AF.request(queryString as! URLConvertible, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    var moviedata: [MovieModel] = []
                    let code = response.response?.statusCode ?? 500
                    result(code, json)
                    
                    
                    
                    //print(self.movieData)
                    
                    //self.searchResultTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        
    }
}
