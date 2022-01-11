//
//  Endpoint.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/29.
//

import Foundation

enum Endpoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup: return .makeEndPoint("auth/local/register")
        case .login: return .makeEndPoint("auth/local")
        case .boards: return .makeEndPoint("boards")
        case .boardDetail(let id): return .makeEndPoint("boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
    static var login: URL {
        return makeEndPoint("auth/login")
    }
    
    static var signup: URL {
        return makeEndPoint("auth/local/register")
    }
    
    static var boards: URL {
        return makeEndPoint("boards")
    }
    
    static func boardDetail(number: Int) -> URL {
        return makeEndPoint("boards/\(number)")
    }
}


extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> (Void)) {
        session.dataTask(endpoint) { data, response, error in
            
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
                    let lottoData = try decoder.decode(T.self, from: data)
                    completion(lottoData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
        }
    }
    
}
