//
//  WebViewController.swift
//  CLASS_WEEK4
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var urlSearchBar: UISearchBar!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        urlSearchBar.delegate = self
    }

}

extension WebViewController: UISearchBarDelegate {
    
    //서치바에서 검색 리턴키를 클릭했을때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let url = URL(string: searchBar.text ?? "") else {
            print("error")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }

    
}
