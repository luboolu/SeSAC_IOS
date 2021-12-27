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
    
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> (Void)) {
        let url = URL(string: "http://test.monocoding.com/auth/local")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //string -> date, dictionary -> JSONSerialization / Codable
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            print(response)
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
    
    
}
