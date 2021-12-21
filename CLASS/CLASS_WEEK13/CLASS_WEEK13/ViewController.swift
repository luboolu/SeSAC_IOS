//
//  ViewController.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    var apiService = APIService()
    
    var castData: Cast? //베열이야하는거 아닌가요? 왜 이렇게 선언했을까?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)

        
        apiService.requestCast { cast in
            print(cast)
            
            self.castData = cast
         
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        

    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.peopleListResult.peopleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //시스템에 미리 정의된 테이블뷰 셀 디자인을 코드로 구현하는 방법!
        //하지만 권장하지 않는게, reuseIdentifier가 의미없게 됨
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: UITableViewCell.reuseIdentifier)
        cell.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        cell.detailTextLabel?.text = "디테일"
        
        return cell
    }
    
    
}

