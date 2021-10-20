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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        //37.556124592490924, 126.97235991352282
        let location = CLLocationCoordinate2D(latitude: 37.556124592490924, longitude: 126.97235991352282)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        theaterMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Here!"
        annotation.coordinate = location
        theaterMapView.addAnnotation(annotation)
        // Do any additional setup after loading the view.

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TheaterMapViewController: MKMapViewDelegate {
    //Map의 Annotation을 클릭하면 뭘 할지 설정
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("나 여기 있다!!!")
    }
}

//3. 위치 권한과 관련한 프로세스를 설정
extension TheaterMapViewController: CLLocationManagerDelegate {

}
