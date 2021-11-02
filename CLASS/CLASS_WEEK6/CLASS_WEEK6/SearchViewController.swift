//
//  SearchViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        // Get all tasks in the realm
        tasks = localRealm.objects(UserDiary.self)
        print(tasks)
        
        
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier) as? SearchResultTableViewCell else {
            print("return")
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
         
        cell.titleLabel.text = row.diaryTitle
        cell.dateLabel.text = "2021.11.02"
        cell.contentLabel.text = row.content
        cell.contentLabel.numberOfLines = 0
        cell.searchImageView.backgroundColor = .blue


        return cell
    }
    
    
}
