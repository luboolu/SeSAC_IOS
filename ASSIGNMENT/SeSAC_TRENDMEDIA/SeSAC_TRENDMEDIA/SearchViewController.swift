//
//  SearchViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    //셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row {
                startPage += 10
                
                fetchMovieData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    static let identifier = "SearchViewController"
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    
    var movieData: [MovieModel] = []
    
    var startPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.prefetchDataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        fetchMovieData()

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchMovieData() {
        //네이버 영화 API 호출하여 결과 debug 찍기
        //%형태로 인코딩 해주어야 함
        if let searchSource = "해리포터".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(searchSource)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id" : "uesxBpa4kC9tztddyWGr",
                "X-Naver-Client-Secret" : "GRMNLkQCNF"
            ]
            
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
                    
                    self.searchResultTableView.reloadData()
                    
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
        
        cell.overviewLable.text = "영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 "
        cell.overviewLable.font = .systemFont(ofSize: 15, weight: .light)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
