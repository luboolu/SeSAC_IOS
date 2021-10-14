//
//  MovieTableViewController.swift
//  CLASS_211012
//
//  Created by 김진영 on 2021/10/13.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    let movieInformation = MovieInformation()

    override func viewDidLoad() {
        super.viewDidLoad()

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


}
