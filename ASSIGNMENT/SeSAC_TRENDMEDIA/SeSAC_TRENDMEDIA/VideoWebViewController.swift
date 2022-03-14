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
    
    var videoInfo: [TMDBVideoModel] = []
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideoData()
        loadWebView()
    }
    
    func fetchVideoData() {
        

        print(#function)
        TmdbAPIManager.shared.fetchVideoData(movieID: String(movieID!)) {
            code, json in
            
            for result in json["results"] {
                //print(result.1)
                let data = TMDBVideoModel(
                    site: result.1["site"].stringValue,
                    type: result.1["type"].stringValue,
                    name: result.1["name"].stringValue,
                    official: result.1["official"].boolValue,
                    key: result.1["key"].stringValue
                )
                //print(self.videoInfo)
                self.videoInfo.append(data)
            }
            //https://www.youtube.com/watch?v="key"가 비디오 주소
            
            print(self.loadWebView())
        }
        
    

    }
    
    func loadWebView() {
        print(#function)
        //좀 더 괜찮은 방법 생각해내기
        for video in self.videoInfo {
            if video.official == true {
                if let url = URL(string: "https://www.youtube.com/watch?v=\(video.key)") {
                    let request = URLRequest(url: url)
                    self.webView.load(request)
                }
            }
            break
        }
        
        
        

    }
    
    


}
