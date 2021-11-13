//
//  Alert+Extension.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/12.
//

import Foundation
import UIKit

extension UIAlertController{
    
    var alertFixOver: UIAlertController {
        
        let alert = UIAlertController(title: "에러", message: "고정 메모는 최대 5개 까지 가능합니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (action) in
                    
        }
        alert.addAction(okAction)
        
        return alert
    }
    
    //action 설정 때문에 extension으로 하는거 보류..
//    var alertDeleteMemo: UIAlertController {
//
//        let alert = UIAlertController(title: "확인", message: "메모를 정말 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "", style: <#T##UIAlertAction.Style#>, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
//
//    }
    
}
