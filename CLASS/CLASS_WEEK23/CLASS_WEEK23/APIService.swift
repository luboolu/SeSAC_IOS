//
//  APIService.swift
//  CLASS_WEEK23
//
//  Created by 김진영 on 2022/03/03.
//

import Foundation

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

final class APIService {
    
    let urlString = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=950"
    var number = 0
    
    func callRequest(completionHander: @escaping (Int) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        //if Error == nil: api 통신에 성공함 -> Data는 nil이 아닐것
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let value = try JSONDecoder().decode(Lotto.self, from: data)
                self.number = value.drwtNo1
                completionHander(self.number)
            } catch {
                return
            }

        }
        
        task.resume()
    }
}
