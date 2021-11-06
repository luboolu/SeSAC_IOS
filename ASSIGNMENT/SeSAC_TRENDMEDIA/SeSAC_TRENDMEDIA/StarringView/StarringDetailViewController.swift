//
//  StarringDetailViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/18.
//

import UIKit
import Network
import Kingfisher

class StarringDetailViewController: UIViewController {
    
    var creditID: String?
    var movieData: [TMDBCastModel] = []
    
    let networkMonitor = NWPathMonitor()

    @IBOutlet weak var starDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starDetailTableView.delegate = self
        starDetailTableView.dataSource = self
        
        fetchCreditData()
        // Do any additional setup after loading the view.
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
    
    func fetchCreditData() {
        print(#function)
        TmdbAPIManager.shared.fetchCreditData(creditID: creditID ?? "") {
            code, json in
            //다른 json들 처럼 똑같이 접근하려고 했는데, 안뜬다! 다음에 해결할것
            //print(json)
            print(json["person"]["known_for"])
            for media in json["person"]["known_for"] {
                print(media.1["title"].stringValue)
                
                let data = TMDBCastModel(
                    genreID: media.1["genre_ids"].rawValue as! [Int],
                    overview: media.1["overview"].stringValue,
                    originalLanguage: media.1["original_language"].stringValue,
                    originalTitle: media.1["original_title"].stringValue,
                    posterPath: media.1["poster_path"].stringValue,
                    backdropPath: media.1["backdrop_path"].stringValue,
                    voteAverage: media.1["vote_average"].doubleValue,
                    title: media.1["title"].stringValue,
                    releaseDate: media.1["release_date"].stringValue,
                    id: media.1["id"].intValue,
                    character: media.1["character"].stringValue)
                
                self.movieData.append(data)
            }
            
            self.starDetailTableView.reloadData()

        }
    }

}

extension StarringDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StarringDetailTableViewCell") as? StarringDetailTableViewCell else {
            print("return!!!")
            return UITableViewCell()
        }
        
        let row = movieData[indexPath.row]
        
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(row.posterPath)")
        cell.posterImageView.kf.setImage(with: url)

        cell.movieTitleLabel.text = row.title
        
        cell.nameLabel.text = row.overview
        cell.nameLabel.numberOfLines = 0
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }

}
