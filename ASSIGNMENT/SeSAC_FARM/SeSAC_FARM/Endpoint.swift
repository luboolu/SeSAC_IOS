//
//  Endpoint.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import Foundation

enum Endpoint {
    case signup
    case signin
    case post
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup: return .makeEndPoint("/auth/local/register")
        case .signin: return .makeEndPoint("/auth/local")
        case .post: return .makeEndPoint("/posts")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
    static var signin: URL {
        return makeEndPoint("/auth/local")
    }
    
    static var signup: URL {
        return makeEndPoint("/auth/local/register")
    }
    
    static var post: URL {
        return makeEndPoint("/posts")
    }
}


extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                print("data=======================")
                print(data)
                print("response===================")
                print(response)
                print("error======================")
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
                    let lottoData = try decoder.decode(T.self, from: data)
                    completion(lottoData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
        }
    }
    
}
