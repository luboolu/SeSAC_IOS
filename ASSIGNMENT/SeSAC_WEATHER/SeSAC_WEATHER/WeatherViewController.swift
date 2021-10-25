//
//  WeatherViewController.swift
//  SeSAC_WEATHER
//
//  Created by 김진영 on 2021/10/25.
//

import UIKit
import SwiftyJSON
import Alamofire

import CoreLocation
import CoreLocationUI

class WeatherViewController: UIViewController {

    static let indetifier = "WeatherViewController"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var mentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2.
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        designSetteing()
        
        
        
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
    }
    
    func designSetteing() {
        temperatureLabel.clipsToBounds = true
        temperatureLabel.layer.cornerRadius = 10
        
        humidityLabel.clipsToBounds = true
        humidityLabel.layer.cornerRadius = 10
        
        
        weatherImageView.layer.cornerRadius = 10
        
        mentLabel.clipsToBounds = true
        mentLabel.layer.cornerRadius = 10
        
        windLabel.clipsToBounds = true
        windLabel.layer.cornerRadius = 10
    }
    
}


//3. 위치 권한과 관련한 프로세스를 설정
extension WeatherViewController: CLLocationManagerDelegate {
    //9. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkLocationServicesAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus =
            CLLocationManager.authorizationStatus()
        }
        
        //iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능(8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
            
        }
    }
    
    //8. 사용자의 권란 상태 확인(UDF: 사용자 정의 함수로 프로토콜 내 메셔드가 아님!)
    //사용자가 위치를 허용했는지 안했는지, 거부한건지 이런 권한을 확인! (단, iOS의 위치 서비스가 가능한지 확인)
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //개발자가 지정하는 위치서비스의 정확도
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() //위치 접근 시작 -> didUpdateLocations 실행
        case .restricted:
            print("DENIED, 설정으로 유도")
        case .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() //위치 접근 시작 -> didUpdateLocations 실행
        case .authorizedAlways:
            print("Always")
        @unknown default:
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *) {
            //정확도 체크: 정확도 감소가 되어 있을경우, 1시간 4번만 위치가 기록됨, 미리 알림 실행 안될수도, 대신 배터리는 오래 쓸 수 있음, 워치7부터 위치 정보가 동기화됨
            let accuarancyState = locationManager.accuracyAuthorization
            
            switch accuarancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
            }
        }
        
        
    }

    //4. 사용자가 위치 허용을 한 경우 실행되는 부분
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {

            let findLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
                
                if let address: [CLPlacemark] = placemarks { if let name: String = address.last?.name {
                    print(name) } //전체 주소
                }
                
            })
                
            
            
        } else {
            print("Location Cannot Find")
        }
        //print(locations)
    }
    
    //5.위치 접근이 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        
        let alert = UIAlertController(title: "위치 권한을 허용해주세요.", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "네", style: .default, handler: { action in
            //'네'가 눌리면 위치 권한을 설정할 수 있는 아이폰 설정 화면으로 연결
            // 설정창의 url 생성
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            // 열 수 있는 url 이라면, 이동
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }))
        self.present(alert, animated: true)
        

        
    }
    
    //6. iOS14 미만: 앱이 위치 관리자를 생성하고, 승인 상태가 변경 될 때 대리자에게 승인 상태를 알려줌
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkLocationServicesAuthorization()
    }
    
    //7.iOS14 이상: 앱이 위치 관리자를 생성하고, 승인 상태가 변경될 때 대리자에게 승인 상태를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkLocationServicesAuthorization()
    }
    
}