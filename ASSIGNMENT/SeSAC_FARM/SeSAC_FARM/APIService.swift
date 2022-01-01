//
//  APIService.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
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
//    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> (Void)) {
//        let url = URL(string: "http://test.monocoding.com/auth/local")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        //string -> date, dictionary -> JSONSerialization / Codable
//        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
//
//        URLSession.request(.shared, endpoint: request, completion: completion)
//
//
//    }
    
    //회원가입 SignUp
    static func signUp(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> (Void)) {
        
        let url = URL(string: "\(URL.signup)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(.shared, endpoint: request, completion: completion)
        print(request.url)
    }
}
