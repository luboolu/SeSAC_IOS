//
//  APIService.swift
//  SeSAC_BEER
//
//  Created by 김진영 on 2021/12/24.
//

import Foundation

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_service"
}

//self.rawValue로 해두면 case가 추가되더라도 쉽게 대응 가능
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
    
    //Beer API
    let sourceURL = URL(string: "https://api.punkapi.com/v2/beers")!
    
    func requestBeer(completion: @escaping (Beer?) -> Void) {
        
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                self.showAlert(.unknownError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError)
                return
            }
            
            if let data = data, let beerData = try? JSONDecoder().decode(Beer.self, from: data) {
                print("SUCCED", beerData)
                completion(beerData)
                return
            }
            
            completion(nil)

        }.resume()
        
    }
    
    func showAlert(_ msg: APIError) {
        print(msg)
    }
}
