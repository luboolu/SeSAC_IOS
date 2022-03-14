//
//  VisionAPIManager.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage

class VisionAPIManager {
    static let shared = VisionAPIManager()
    
    func fecthFaceData(image: UIImage ,result: @escaping (Int, JSON) -> () ) {
        let header: HTTPHeaders = [
            "Authorization": APIKey.KAKAO,
            "Content-Type": "multipart/form-data"
        ]
        
        //UIImage를 바이너리 타입으로 변환
        guard let imageData = image.pngData() else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image" )
        }, to: Endpoint.visionURL, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
                
                

                
            case .failure(let error):
                print(error)
            }
        }
    }
}
