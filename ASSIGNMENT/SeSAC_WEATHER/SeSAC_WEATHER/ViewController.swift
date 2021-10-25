//
//  ViewController.swift
//  SeSAC_WEATHER
//
//  Created by 김진영 on 2021/10/25.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getCurrentWeather()
    }

    func getCurrentWeather() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid={}"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }

}

