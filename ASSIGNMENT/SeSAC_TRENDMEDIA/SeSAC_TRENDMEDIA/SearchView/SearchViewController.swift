//
//  SearchViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit
import Network

import SwiftyJSON
import Alamofire
import Kingfisher

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    //셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row {
                startPage += 10

                fetchMovieData(query: searchBar.text!)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    static let identifier = "SearchViewController"
    let networkMonitor = NWPathMonitor()
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieData: [MovieModel] = []
    
    var startPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkMonitoring()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.prefetchDataSource = self
        searchBar.delegate = self
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        fetchMovieData(query: "")

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func networkMonitoring() {
        //네트워크 변경 감지 클래스를 통해 사용자의 네트워크 상태가 변경될 때 마다 실행
        networkMonitor.pathUpdateHandler = { path in
            //클로져 구문
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("Cellular Wifi")
                } else {
                    print("Other")
                }
            } else {
                print("Network Disconnected")
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "네트워크 에러", message: "네트워크 연결에 실패했습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false, completion: nil)
                }
                
            }
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }
    
    func fetchMovieData(query: String) {
        //네이버 영화 API 호출하여 결과 debug 찍기
        //%형태로 인코딩 해주어야 함
        if let searchSource = "\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "\(Endpoint.NaverMovieSearchURL)?query=\(searchSource)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id" : APIKEY.NAVER_ID,
                "X-Naver-Client-Secret" : APIKEY.NAVER_SECRETE
            ]
            print(url)
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    for item in json["items"].arrayValue {
                        let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let sub = item["subtitle"].stringValue
                        
                        let data = MovieModel(title: title, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                        
                        
                        self.movieData.append(data)
                    }
                    
                    print(self.movieData)
                    //중요!!!
                    DispatchQueue.main.async {
                        self.searchResultTableView.reloadData()
                    }
                
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SerachResultCell") as? SearchResultTableViewCell else {
            return UITableViewCell()
        }

        let row = movieData[indexPath.row]
        
        
        let url = URL(string: row.imageData)

        cell.searchImageView.kf.setImage(with: url) //Kingfisher 이용하여 이미지 url로 load
        
        cell.titleLable.text = row.title
        cell.titleLable.font = .systemFont(ofSize: 18, weight: .light)
        
        cell.overviewLable.text = "\(row.userRatingData)"
        cell.overviewLable.font = .systemFont(ofSize: 15, weight: .light)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    //검색 버튼(키보드 리턴키와 비슷)을 눌렀을때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        //searchBar.setShowsCancelButton(false, animated: true)
        if let text = searchBar.text {
            self.startPage = 1
            self.movieData.removeAll()
            fetchMovieData(query: text)
        }
    }
    
    //취소 버튼 눌렀을때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        self.startPage = 1
        self.movieData.removeAll()
        searchResultTableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        //searchBar.showsCancelButton = false
    }
    
    //서치바에 커서가 깜빡이기 시작할때를 감지
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
        //searchBar.showsCancelButton = true
    }
}
