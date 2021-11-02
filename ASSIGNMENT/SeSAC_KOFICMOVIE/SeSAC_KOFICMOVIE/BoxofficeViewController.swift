//
//  BoxofficeViewController.swift
//  SeSAC_KOFICMOVIE
//
//  Created by 김진영 on 2021/11/02.
//

import UIKit
import SwiftyJSON

class BoxofficeViewController: UIViewController {
    
    var boxofficeData: [DaliyBoxoffice] = []
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var boxofficeTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boxofficeTableView.dataSource = self
        boxofficeTableView.delegate = self
        
        boxofficeTableView.backgroundColor = .none
        boxofficeTableView.backgroundView?.alpha = 0
        
        // Do any additional setup after loading the view.
        fetchBoxofficeData()
    }
    
    func fetchBoxofficeData() {
        KoficAPIManager.shared.fetchBoxofficeData(date: "20211101") { code, json in
            
            for data in json["boxOfficeResult"]["dailyBoxOfficeList"] {
                //print(data.1)
                
                let boxoffice = DaliyBoxoffice(
                    boxofficeType: data.1["boxofficeType"].stringValue,
                    showRange: data.1["showRange"].stringValue,
                    rnum: data.1["rnum"].stringValue,
                    rank: data.1["rank"].stringValue,
                    rankInten: data.1["rankInten"].stringValue,
                    rankOldAndNew: data.1["rankOldAndNew"].stringValue,
                    movieCD: data.1["movieCD"].stringValue,
                    movieNm: data.1["movieNm"].stringValue,
                    openDt: data.1["openDt"].stringValue,
                    salesAmt: data.1["salesAmt"].stringValue,
                    salesShare: data.1["salesShare"].stringValue,
                    salesChange: data.1["salesChange"].stringValue,
                    salesAcc: data.1["salesAcc"].stringValue,
                    audiCnt: data.1["audiCnt"].stringValue,
                    audiIntenL: data.1["audiIntenL"].stringValue,
                    audiChange: data.1["audiChange"].stringValue,
                    audiAcc: data.1["audiAcc"].stringValue,
                    scrnCnt: data.1["scrnCnt"].stringValue,
                    showCnt: data.1["showCnt"].stringValue
                )
                
                self.boxofficeData.append(boxoffice)
            }
            self.boxofficeTableView.reloadData()
//            print(self.boxofficeData)
            
//            print(self.boxofficeData[0])
        }
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        
        
        
    }
    

}

extension BoxofficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.boxofficeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.boxofficeData.count == 0 {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxofficeTableViewCell.identifier) as? BoxofficeTableViewCell else{
            return UITableViewCell()
        }
     
        let row = self.boxofficeData[indexPath.row]

        cell.rankLabel.text = row.rank
        cell.rankLabel.textColor = .black
        cell.rankLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        cell.titleLabel.text = row.movieNm
        cell.titleLabel.textColor = .white
        cell.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)

        cell.releaseDateLabel.text = row.openDt
        cell.releaseDateLabel.textColor = .white
        cell.releaseDateLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
