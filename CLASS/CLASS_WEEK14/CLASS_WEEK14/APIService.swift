//
//  APIService.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/27.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class APIService {
    
    //로그인
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> (Void)) {
        let url = URL(string: "http://test.monocoding.com/auth/local")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //string -> date, dictionary -> JSONSerialization / Codable
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)

        URLSession.request(.shared, endpoint: request, completion: completion)

    }
    
    //회원가입 sign up
    static func signUp(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> (Void)) {
        let url = URL(string: "http://test.monocoding.com/auth/local/register")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //string -> date, dictionary -> JSONSerialization / Codable
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data==========================================")
            print(data)
            print("response======================================")
            print(response)
            print("error=========================================")
            print(error)
            
            guard error == nil else {
                completion(nil, .failed)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                completion(nil, .failed)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
            }

            
        }.resume()
    }
    
    //동행복권
    static func lotto(_ number: Int, completion: @escaping (Lotto?, APIError?) -> (Void)) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
 
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let lottoData = try decoder.decode(Lotto.self, from: data)
                    completion(lottoData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            


            
        }.resume()
    }
    
    //TMDB
    static func person(_ text: String, page: Int , completion: @escaping (Person?, APIError?) -> (Void)) {
        
        //5b2646eba70f38e9484223101e68395f
        
        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=YOURKEY&language=en-US&query=%ED%98%84%EB%B9%88&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let key = "5b2646eba70f38e9484223101e68395f"
        let language = "ko-KR"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]
 
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let personData = try decoder.decode(Person.self, from: data)
                    completion(personData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            


            
        }.resume()
    }
    
    
    
}
