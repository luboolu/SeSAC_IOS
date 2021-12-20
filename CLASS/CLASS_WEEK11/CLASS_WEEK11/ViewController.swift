//
//  ViewController.swift
//  CLASS_WEEK11
//
//  Created by 김진영 on 2021/12/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//          AnalyticsParameterItemID: "id-\(title!)",
//          AnalyticsParameterItemName: title!,
//          AnalyticsParameterContentType: "cont",
//        ])
        
        Analytics.logEvent("share_image", parameters: [
          "name": "name" as NSObject,
          "full_text": "text" as NSObject,
        ])
    }
    
    @IBAction func crashButtonClicked(_ sender: UIButton) {
        
        //컬렉션뷰 선택되면 화면전환
        let st = UIStoryboard(name: "UserTagAlbumDetail", bundle: nil)
        if let vc = st.instantiateViewController(withIdentifier: UserTagAlbumViewController.identifier) as? UserTagAlbumViewController {
            
            
            vc.modalPresentationStyle = .fullScreen
                
            //navigation bar를 포함하여 다음 뷰 컨트롤러로 화면전환 - push
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    


}

