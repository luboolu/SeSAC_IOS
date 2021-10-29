//
//  StarringDetailViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/18.
//

import UIKit

class StarringDetailViewController: UIViewController {
    
    var creditID: String?
    var movieData: [TMDBModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCreditData()
        // Do any additional setup after loading the view.
    }
    
    func fetchCreditData() {
        TmdbAPIManager.shared.fetchCreditData(creditID: creditID ?? "") {
            code, json in
            //다른 json들 처럼 똑같이 접근하려고 했는데, 안뜬다! 다음에 해결할것
            print(json["known_for"])
            for media in json["known_for"] {
                print(media)
            }

        }
    }

}
