//
//  APIService.swift
//  SeSAC_TMDBDRAMA
//
//  Created by 김진영 on 2021/12/26.
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
    
    //TMDB TV Top Rated API
    let sourceURL = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=5b2646eba70f38e9484223101e68395f&language=en-US&page=1")!
    
    func requestTmdbTvTopRated(startPage: Int, completion: @escaping (TmdbTv?) -> Void) {
        
        let sourcrURLPage = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=5b2646eba70f38e9484223101e68395f&language=en-US&page=\(startPage)")!
        
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
            
            if let data = data, let tmdbData = try? JSONDecoder().decode(TmdbTv.self, from: data) {
                print("SUCCED")
                completion(tmdbData)
                return
            }
            
            completion(nil)

        }.resume()
        
    }
    
    func showAlert(_ msg: APIError) {
        print(msg)
    }
    
}
