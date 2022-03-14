//
//  MovieTableViewController.swift
//  CLASS_211012
//
//  Created by 김진영 on 2021/10/13.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    //Pass Data1. 데이터를 전달 받을 공간
    //어떤 값을 받을지에 따라서 타입을 명시헤 둬야 함
    var titleSpace: String?
    
    let movieInformation = MovieInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pass Data2. 표현
        title = titleSpace
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))

    }
    
    @objc func closeButtonClicked() {
        
        //Push - Pop
        //Push: Dismiss X, Present
        self.navigationController?.popViewController(animated: true)
        //이렇게 했을때 대신 백버튼 제스쳐는 동작하지 않게 됨
        
        //Push로 화면전환 되었을때 dismiss로 화면 닫는 것을 못한다!
        //self.dismiss(animated: true, completion: nil)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInformation.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //커스텀 셀을 사용할땐 indexPath를 전달하는 for 매개변수도 같이 사용한다
        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let row = movieInformation.movie[indexPath.row]
        
        cell.posterImageView.backgroundColor = .red
        cell.posterImageView.image = UIImage(named: row.title)
        cell.titleLabel.text = row.title //title만 색깔이 다른 이유는,,애플의 예약어라서
        cell.releaseDateLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7 //디바이스별 크기를 받아와서 각기 다르게 적용해준다
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Movie", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            print("ERROR")
            return
        }
        
        let row = movieInformation.movie[indexPath.row]
        
        vc.movieData = row
//        vc.releaseDate = row.releaseDate
//        vc.overview = row.overview
//        vc.runtime = row.runtime
//        vc.rate = row.rate
//        vc.movieTitle = row.title
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
