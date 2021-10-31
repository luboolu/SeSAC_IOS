//
//  StarringViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit
import Network

import Kingfisher

class StarringViewController: UIViewController {
    
    var movieInfo: TMDBModel?
    var castInfo: [TMDBGetCastModel] = []
    var crewInfo: [TMDBGetCastModel] = []
    var overviewExpanse = false
    
    let networkMonitor = NWPathMonitor() //네트워크 변경 감시자
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var mainPosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }
        }
        networkMonitor.start(queue: DispatchQueue.global())
        
        actorTableView.delegate = self
        actorTableView.dataSource = self
        
        //print(tvShow?.title)
 
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movieInfo!.backdropPath)")
        mainPosterImageView.kf.setImage(with: url)
        
        titleLabel.text = movieInfo?.title
        titleLabel.textColor = .white
        
        actorTableView.tableHeaderView = headerView
        
        fetchStarringData()
        
        print(self.castInfo)
    }
    
    @IBAction func overviewButtonClicked(_ sender: UIButton) {
        print(#function)

        
        overviewExpanse = !overviewExpanse
        
        if let cell = actorTableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell {
            if overviewExpanse {
                cell.overviewButton.setImage(UIImage(named: "chevron.down"), for: .normal)
            } else {
                cell.overviewButton.setImage(UIImage(named: "chevron.up"), for: .normal)
            }
            
            actorTableView.reloadData()
            
        }

    }
    
    func fetchStarringData() {
        print(#function)
        TmdbAPIManager.shared.fetchGetCreditData(ID: Int(movieInfo?.id ?? 0)) { code, json in
            //print(json)
            //print(json["cast"])
            
            for result in json["cast"] {
                //print(result.1["name"].stringValue)
                let data = TMDBGetCastModel(
                    gender: result.1["gender"].intValue,
                    id: result.1["id"].intValue,
                    department: result.1["known_for_department"].stringValue,
                    name: result.1["name"].stringValue,
                    originalName: result.1["original_name"].stringValue,
                    porofilePath: result.1["profile_path"].stringValue,
                    character: result.1["character"].stringValue,
                    creditID: result.1["credit_id"].stringValue
                )

                self.castInfo.append(data)
            }
            
            self.actorTableView.reloadData()
            
        }
        
    }
    



    

}

extension StarringViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.castInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell")
            
            cell?.textLabel?.text = movieInfo?.overview

            return cell!


        } else {
    
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as? ActorTableViewCell else {
               return UITableViewCell()
           }
            
            
            let row = castInfo[indexPath.row - 1]
            
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(row.porofilePath)")
            cell.actorImageView.kf.setImage(with: url) //Kingfisher 이용하여 이미지 url로 load
           
            cell.actorProfile1.text = row.name
            cell.actorProfile1.font = .systemFont(ofSize: 15, weight: .bold)

            cell.actorProfile2.text = row.character
            cell.actorProfile2.font = .systemFont(ofSize: 12, weight: .light)

            return cell

        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "StarringDetailViewController") as? StarringDetailViewController else {
            print("ERROR")
            return
        }
        
        
        vc.title = castInfo[indexPath.row - 1].name
        vc.creditID = castInfo[indexPath.row - 1].creditID

        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
}
