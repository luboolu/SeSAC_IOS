//
//  SearchViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self

    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SerachResultCell") as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        
        cell.searchImageView.image = UIImage(named: "nevertheless")
        
        cell.titleLable.text = "영화 제목"
        cell.titleLable.font = .systemFont(ofSize: 18, weight: .light)
        
        cell.overviewLable.text = "영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 영화 줄거리 "
        cell.overviewLable.font = .systemFont(ofSize: 15, weight: .light)
        
        return cell
    }
    
}
