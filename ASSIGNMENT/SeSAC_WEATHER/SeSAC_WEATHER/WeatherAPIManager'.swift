//
//  WeatherAPIManager'.swift
//  SeSAC_WEATHER
//
//  Created by 김진영 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    func fectchWeatherData(lat: Double, lon: Double, result: @escaping (Int, JSON) -> () ) {
        
        let url = Endpoint.openWeatherURL
        
        var queryString = URLComponents(string: url)
        let latitude = URLQueryItem(name: "lat", value: String(lat))
        let longitude = URLQueryItem(name: "lon", value: String(lon))
        let tempUnit = URLQueryItem(name: "units", value: "metric")
        let apiKey = URLQueryItem(name: "appid", value: APIKEY.OPENWEATHER)
        
        queryString?.queryItems = [latitude, longitude, tempUnit, apiKey]
        print(queryString as! URLConvertible)
        AF.request(queryString as! URLConvertible, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }

    }
    
}
