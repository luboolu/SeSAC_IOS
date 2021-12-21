//
//  APIService.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/21.
//

import Foundation

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}
//string, rawvalue로 해두면 추후에 case가 추가되더라도 쉽게 대응할수 있다.

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString(self.rawValue, comment: "")
        case .serverError:
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
}

class APIService {
    
    //영화진흥위원회 api
    
    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    func requestCast(completion: @escaping (Cast?) -> Void) {

        URLSession.shared.dataTask(with: sourceURL, completionHandler: { (data, response, error) in
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                //print("ERROR!")
                self.showAlert(.unknownError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                //print("ERROR!")
                self.showAlert(.serverError)
                return
            }
            
            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                print("SUCCEED", castData)
                completion(castData)
                return
            }
            
            completion(nil)

        }).resume()

    }
    
    func showAlert(_ msg: APIError) {
        print(msg)
    }
}
