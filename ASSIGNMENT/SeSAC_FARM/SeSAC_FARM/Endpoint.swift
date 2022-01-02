//
//  Endpoint.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import Foundation


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


//extension URLSession {
//
//    typealias Handler = (Data?, URLResponse?, Error?) -> Void
//
//    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
//        let task = dataTask(with: endpoint, completionHandler: handler)
//        task.resume()
//
//        return task
//    }
//
//}
