//
//  SeSAC.swift
//  CLASS_WEEK13_FRAMEWORK
//
//  Created by 김진영 on 2021/12/23.
//

import Foundation
import UIKit
import WebKit

open class SeSACOpen: UIViewController {
    open var name: String = "고래밥"
    
    open func openfunction() {
        
    }
    
    public enum TransitionStyle {
        case present, push
    }
    
    public func presentWebViewController(url: String, transitionStyle: TransitionStyle, vc: UIViewController) {
        
        let webViewController = webViewController()
        webViewController.url = url
        
        switch transitionStyle {
        case .present:
            vc.present(webViewController, animated: true, completion: nil)
        case .push:
            vc.navigationController?.pushViewController(webViewController, animated: true)
        }
        
    }
}



class webViewController: UIViewController, WKUIDelegate {
    
    var url: String = "https://www.apple.com"
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: URL(string: url)!)
        webView.load(myRequest)
    }
}


public class SeSACPublic: UIViewController {
    var name: String = "고래밥"
}

internal class SeSACInternal: UIViewController {
    
}
