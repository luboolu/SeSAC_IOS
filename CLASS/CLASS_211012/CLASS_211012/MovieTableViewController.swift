//
//  MovieTableViewController.swift
//  CLASS_211012
//
//  Created by 김진영 on 2021/10/13.
//

import UIKit

class MovieTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //커스텀 셀을 사용할땐 indexPath를 전달하는 for 매개변수도 같이 사용한다
        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.posterImageView.backgroundColor = .red
        cell.titleLabel.text = "7번방의 선물"
        cell.releaseDateLabel.text = "2021.02.02"
        cell.overviewLabel.text = "영화 줄거리가 보이는 곳입니다.영화 줄거리가 보이는 곳입니다.영화 줄거리가 보이는 곳입니다.영화 줄거리가 보이는 곳입니다.영화 줄거리가 보이는 곳입니다.영화 줄거리가 보이는 곳입니다.영화 줄거리가 보이는 곳입니다."
        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7 //디바이스별 크기를 받아와서 각기 다르게 적용해준다
    }


}
