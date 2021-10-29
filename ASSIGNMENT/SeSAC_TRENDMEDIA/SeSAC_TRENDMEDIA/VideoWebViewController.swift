//
//  VideoWebViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/30.
//

import UIKit
import WebKit

class VideoWebViewController: UIViewController {
    
    static let identifier = "VideoWebViewController"
    
    var movieID: Int?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = URL(string: "")
//        let request = URLRequest(url: url)
//        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
