//
//  MovieTrendInfoViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit
import Network

import Kingfisher

class MovieTrendInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    //셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if self.trendData.count - 1 == indexPath.section {
                start += 1
                fetchTMDBData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    let tvShowInformation = TvShowInformation()
    
    let networkMonitor = NWPathMonitor() //네트워크 변경 감시자
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var mainButtonView: UIView!
    @IBOutlet weak var InfoTableView: UITableView!
    
    var trendData: [TMDBModel] = []
    
    var start: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkMonitoring()
        
        InfoTableView.delegate = self
        InfoTableView.dataSource = self
        InfoTableView.prefetchDataSource = self
        
        InfoTableView.rowHeight = UITableView.automaticDimension
        
        mainButtonView.layer.zPosition = 1
        mainButtonView.layer.cornerRadius = 20
        
        fetchTMDBData()
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
    
    func fetchTMDBData() {
        TmdbAPIManager.shared.fetchTrendData(startPage: start) {
            code, json in

            for result in json["results"] {
                //print(result.1["title"])
                let data = TMDBModel(
                    id: result.1["id"].intValue,
                    title: result.1["title"].stringValue,
                    backdropPath: result.1["backdrop_path"].stringValue,
                    voteCount: result.1["vote_count"].intValue,
                    overview: result.1["overview"].stringValue,
                    popularity: result.1["popularity"].doubleValue,
                    posterPath: result.1["poster_path"].stringValue,
                    video: result.1["video"].boolValue,
                    mediaType: result.1["media_type"].stringValue,
                    voteAverage: result.1["vote_average"].doubleValue,
                    adult: result.1["adult"].boolValue,
                    originalLanguage: result.1["original_language"].stringValue,
                    genreID: result.1["genre_ids"].rawValue as! [Int],
                    releaseDate: result.1["release_date"].stringValue,
                    originalTitle: result.1["original_title"].stringValue
                )
                
                self.trendData.append(data)

            }
            
            self.InfoTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.trendData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell") as? PosterTableViewCell else {
                return UITableViewCell()
            }
            
            //let row = tvShowInformation.tvShow[indexPath.section]
            let row = trendData[indexPath.section]
            
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(row.posterPath)")
            cell.posterImageView.kf.setImage(with: url) //Kingfisher 이용하여 이미지 url로 load
            
            
            cell.rateNameLabel.text = "평점"
            cell.rateNameLabel.font = .systemFont(ofSize: 15, weight: .medium)
            cell.rateNameLabel.backgroundColor = .purple
            
            cell.rateNumLabel.text = String(row.voteAverage)
            cell.rateNumLabel.font = .systemFont(ofSize: 15, weight: .medium)
            cell.rateNumLabel.backgroundColor = .white
            
            return cell
            
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InfoTableViewCell else {
                return UITableViewCell()
            }
            
            //let row = tvShowInformation.tvShow[indexPath.section]
            let row = trendData[indexPath.section]
            
            cell.movieTitleLable.text = row.title
            cell.movieTitleLable.font = .systemFont(ofSize: 25)
            
            cell.movieCastLabel.text = "출연진"
            cell.movieCastLabel.font = .systemFont(ofSize: 15, weight: .light)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") else {
                return UITableViewCell()
            }
            
            return cell
        }

        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 300
        } else if indexPath.row == 1 {
            return 88
        } else {
            return 44
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            
            print("video web view로 이동@")
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            guard let vc = sb.instantiateViewController(withIdentifier: "VideoWebViewController") as? VideoWebViewController else {
                print("ERROR")
                return
            }
            
            vc.movieID = trendData[indexPath.section].id

            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 2 {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            guard let vc = sb.instantiateViewController(withIdentifier: "StarringViewController") as? StarringViewController else {
                print("ERROR")
                return
            }
            
            vc.movieInfo = trendData[indexPath.section]

            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        print(#function)
        
        //1.스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        
        //2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        //nav.modalTransitionStyle = .partialCurl// full screen일때만 된다고 앱이 꺼진다!
        
        //3. present 방식으로 화면 전환
        self.present(nav, animated: true, completion: nil)
        
    }
    

    @IBAction func mapButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
        //1.스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: TheaterMapViewController.identifier) as! TheaterMapViewController
        
        //2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        //nav.modalTransitionStyle = .partialCurl// full screen일때만 된다고 앱이 꺼진다!
        
        //3. present 방식으로 화면 전환
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        print(#function)
        //1.스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2.스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: BookViewController.identifier) as! BookViewController
        
        //2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        //3.present 방식으로 화면 전환
        self.present(nav, animated: true, completion: nil)
        
        
    }
    
}


