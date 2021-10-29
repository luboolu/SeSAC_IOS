//
//  TheaterMapViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

class TheaterMapViewController: UIViewController {
    
    static let identifier = "TheaterMapViewController"

    
    @IBOutlet weak var theaterMapView: MKMapView!
    
    //1. MapView를 사용하기 위해 CLLocationManager를 불러온다!
    let locationManager = CLLocationManager()
    
    let theaterLocation = TheatherInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theaterMapView.delegate = self
        
        //2.
        locationManager.delegate = self
        
        //Navigation Bar Button Item 생성 - 닫기 버튼 & 필터 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        

//        let location = CLLocationCoordinate2D(latitude: theaterLocation.theater[0].latitude, longitude: theaterLocation.theater[0].longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: location, span: span)
//        theaterMapView.setRegion(region, animated: true)
        
        
        
        var annotations: [MKPointAnnotation] = []
        for i in (0...(theaterLocation.theater.count - 1)) {
            print(theaterLocation.theater[i])
            let row = theaterLocation.theater[i]
            let location = CLLocationCoordinate2D(latitude: row.latitude, longitude: row.longitude)
            
            let annotation = MKPointAnnotation()
            annotation.title = row.location
            annotation.coordinate = location
            
            annotations.append(annotation)
        }
        theaterMapView.addAnnotations(annotations)
        
        

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func filterButtonClicked() {
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "Filter", message: "메가박스", preferredStyle: .actionSheet)
        //2. UIAlertAction 생성: 버튼들을...
        let ok = UIAlertAction(title: "취소", style: .default)
        //3. 1 + 2
        alert.addAction(ok)
        //4. present
        present(alert, animated: true, completion: nil)
    }
    
}

extension TheaterMapViewController: MKMapViewDelegate {
    //Map의 Annotation을 클릭하면 뭘 할지 설정

}

//3. 위치 권한과 관련한 프로세스를 설정
extension TheaterMapViewController: CLLocationManagerDelegate {
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

            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            theaterMapView.setRegion(region, animated: true)
        } else {
            print("Location Cannot Find")
        }
        print(locations)
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
        
        
        //서울시청을 지도의 중심으로 설정
        //37.56925790910781, 126.97431329455056
        let location = CLLocationCoordinate2D(latitude: 37.56925790910781, longitude: 126.97431329455056)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        theaterMapView.setRegion(region, animated: true)
        
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
