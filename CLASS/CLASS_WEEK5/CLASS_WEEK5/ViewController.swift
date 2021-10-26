//
//  ViewController.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var currentWindLabel: UILabel!
    
    @IBOutlet weak var currentHumidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37&lon=126&appid=39c83516f908c571796fe9689e4b0bf5"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let currentTemp = json["main"]["temp"].doubleValue - 273.15 //옵셔널에 따라 double, doubleValue, 켈빈 온도이므로 섭씨로 변환
                
                print("현재온도 \(currentTemp)")
                self.currentTempLabel.text = "\(Int(currentTemp))C"
                
                let currentWind = json["wind"]["speed"].doubleValue
                print("현재풍속 \(currentWind)")
                self.currentWindLabel.text = "\(currentWind) m/s"
                
                let currentHumidity = json["main"]["humidity"]
                print("현재습도 \(currentHumidity)")
                self.currentHumidityLabel.text = "\(currentHumidity) %"
                
            case .failure(let error):
                print(error)
            }
        }
    }


}

