//
//  BoxofficeViewController.swift
//  SeSAC_KOFICMOVIE
//
//  Created by 김진영 on 2021/11/02.
//

import UIKit

import SwiftyJSON
import RealmSwift
import JGProgressHUD

class BoxofficeViewController: UIViewController {
    
    let localRealm = try! Realm()
    let progress = JGProgressHUD()
    
    var boxofficeData: [DaliyBoxoffice] = []
    var yesterday: String = ""
    var searchDate: String = ""
    var tasks: Results<UserSearch>!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var boxofficeTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm is loacaed at: ", localRealm.configuration.fileURL!)
        //file:///Users/gimjin-yeong/Library/Developer/CoreSimulator/Devices/323D6275-A8A0-44E0-80CE-AA24BF58B1F4/data/Containers/Data/Application/142AA108-3779-4B2F-A7FC-F35B0D01C903/Documents/default.realm
        
        //file:///Users/gimjin-yeong/Library/Developer/CoreSimulator/Devices/323D6275-A8A0-44E0-80CE-AA24BF58B1F4/data/Containers/Data/Application/2D1E41F9-D919-4003-B653-4065DEA31A45/Documents/default.realm
        
        boxofficeTableView.dataSource = self
        boxofficeTableView.delegate = self
        
        boxofficeTableView.backgroundColor = .none
        boxofficeTableView.backgroundView?.alpha = 0
        
        //처음에 앱을 실행했을때, 어제 날짜의 백스오피스 순위를 보여줘여함.
        //yyyyMMdd의 형식으로 Date Formatting 필요
        let now = Date()
        let dateFomatter = DateFormatter()
        
        dateFomatter.dateFormat = "yyyyMMdd"
        
        let day = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        
        self.yesterday = dateFomatter.string(from: day)
        self.searchDate = dateFomatter.string(from: day)
        print("yesterday: \(self.yesterday)")
        // Do any additional setup after loading the view.
        fetchData(date: self.yesterday)
        
    }
    
    func fetchData(date: String) {
        //입력된 date가 유효한 날짜인지 확인
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        if let tmp = dateFormatter.date(from: date) {
            let search = dateFormatter.string(from: tmp)
            //print(search, self.yesterday)
            //print(type(of: search), type(of: self.yesterday))
            if (search <= self.yesterday) && (search >= "20030106") {
                //print("date is valid")
            } else {
                //print("date is invalid")
                self.alertMaker(title: "유효한 날짜를 입력해주세요", message: "ex. 20200101", actionTitle: "네")
                return
            }
            
        } else {
            //print("date is invalid")
            self.alertMaker(title: "유효한 날짜를 입력해주세요", message: "ex. 20200101", actionTitle: "네")
            return
        }
        
        self.searchDate = date
        
        //realm 데이터베이스에 저장된 데이터가 있는지 확인
        // Get all tasks in the realm
        tasks = localRealm.objects(UserSearch.self).filter("searchDate == '\(date)'")
        if tasks.isEmpty == false {
            
            self.boxofficeTableView.reloadData()
            print("reload!!")
            return
        }
        
        
        //유효한 날짜라면 네트워크 통신 시작
        self.progress.show(in: view, animated: true)
        KoficAPIManager.shared.fetchBoxofficeData(date: date) { code, json in
   
            let rankList = List<String>()
            let movieNameList = List<String>()
            let openDateList = List<String>()
            
            for data in json["boxOfficeResult"]["dailyBoxOfficeList"] {
                //print(data.1)
                
//                let boxoffice = DaliyBoxoffice(
//                    boxofficeType: data.1["boxofficeType"].stringValue,
//                    showRange: data.1["showRange"].stringValue,
//                    rnum: data.1["rnum"].stringValue,
//                    rank: data.1["rank"].stringValue,
//                    rankInten: data.1["rankInten"].stringValue,
//                    rankOldAndNew: data.1["rankOldAndNew"].stringValue,
//                    movieCD: data.1["movieCD"].stringValue,
//                    movieNm: data.1["movieNm"].stringValue,
//                    openDt: data.1["openDt"].stringValue,
//                    salesAmt: data.1["salesAmt"].stringValue,
//                    salesShare: data.1["salesShare"].stringValue,
//                    salesChange: data.1["salesChange"].stringValue,
//                    salesAcc: data.1["salesAcc"].stringValue,
//                    audiCnt: data.1["audiCnt"].stringValue,
//                    audiIntenL: data.1["audiIntenL"].stringValue,
//                    audiChange: data.1["audiChange"].stringValue,
//                    audiAcc: data.1["audiAcc"].stringValue,
//                    scrnCnt: data.1["scrnCnt"].stringValue,
//                    showCnt: data.1["showCnt"].stringValue
//                )
//                self.boxofficeData.append(boxoffice)
                
                //realm에 저장할 list append
                rankList.append(data.1["rank"].stringValue)
                movieNameList.append(data.1["movieNm"].stringValue)
                openDateList.append(data.1["openDt"].stringValue)
                
            }
            
            // Add some tasks
            let task = UserSearch(searchDate: date, rank: rankList, movieName: movieNameList, openDate: openDateList)

            try! self.localRealm.write {
                self.localRealm.add(task)
            }
            self.progress.dismiss(animated: true)
            self.boxofficeTableView.reloadData()
        }
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        
        let searchDate = dateTextField.text!
        
        self.boxofficeData.removeAll()
        fetchData(date: searchDate)
        
    }
    
    
    @IBAction func tabGestureRecognizer(_ sender: UITapGestureRecognizer) {
        //키보드가 내리기
        view.endEditing(true)
    }
    
    func alertMaker(title: String, message: String, actionTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: actionTitle, style: .default)
        
        alert.addAction(ok)
        
        self.present(alert, animated: false, completion: nil)
        
    }
    

}

extension BoxofficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let task = localRealm.object(ofType: UserSearch.self, forPrimaryKey: self.searchDate) {
            return task.rank.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if self.boxofficeData.count == 0 {
//            return UITableViewCell()
//        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxofficeTableViewCell.identifier) as? BoxofficeTableViewCell else{
            return UITableViewCell()
        }
     
        //let row = self.boxofficeData[indexPath.row]
        
        //let tasks = localRealm.objects(UserSearch.self).filter("searchDate == '\(self.searchDate)'")
        
        let task = localRealm.object(ofType: UserSearch.self, forPrimaryKey: self.searchDate)!

        cell.rankLabel.text = task.rank[indexPath.row]
        //cell.rankLabel.text = tasks[]
        cell.rankLabel.textColor = .black
        cell.rankLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        cell.titleLabel.text = task.movieName[indexPath.row]
        cell.titleLabel.textColor = .white
        cell.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)

        cell.releaseDateLabel.text = task.openDate[indexPath.row]
        cell.releaseDateLabel.textColor = .white
        cell.releaseDateLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
