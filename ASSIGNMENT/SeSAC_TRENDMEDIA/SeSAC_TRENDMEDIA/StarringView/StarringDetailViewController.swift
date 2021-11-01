//
//  StarringDetailViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/18.
//

import UIKit
import Network

class StarringDetailViewController: UIViewController {
    
    var creditID: String?
    var movieData: [TMDBModel] = []
    
    let networkMonitor = NWPathMonitor()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCreditData()
        // Do any additional setup after loading the view.
    }
    
    func networkMonitoring() {
        //네트워크 변경 감지 클래스를 통해 사용자의 네트워크 상태가 변경될 때 마다 실행
        networkMonitor.pathUpdateHandler = { path in
            //클로져 구문
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("Cellular Wifi")
                } else {
                    print("Other")
                }
            } else {
                print("Network Disconnected")
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "네트워크 에러", message: "네트워크 연결에 실패했습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false, completion: nil)
                }
                
            }
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
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
