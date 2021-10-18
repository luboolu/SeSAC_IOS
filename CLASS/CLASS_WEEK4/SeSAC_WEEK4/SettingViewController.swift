//
//  SettingViewController.swift
//  SeSAC_WEEK4
//
//  Created by 김진영 on 2021/10/18.
//

import UIKit
//CaseIterable: 열거형을 배열처럼 순회할수있게 함
enum SettingSection: Int, CaseIterable {
    case authorization
    case onlineShop
    case question
    
    var description: String {
        switch self {
        case .authorization:
            return "알림 설정"
        case .onlineShop:
            return "온라인 스토어"
        case .question:
            return "Q&A"
        }
    }
}

class SettingViewController: UIViewController  {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let settingList = [
        ["위치 알림 설정", "카메라 알림 설정"],
        ["교보문고", "영풍문고", "반디앤루니스"],
        ["앱스토어 리뷰 작성하기", "문의하기"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        //xib로 테이블뷰 셀을 만든 경우에 필요한 코드
        let nibName = UINib(nibName: DefaultTableViewCell.identifier, bundle: nil)
        settingTableView.register(nibName, forCellReuseIdentifier: DefaultTableViewCell.identifier)
    }

}

//extension을 이런식으로 활용할수도 있다.
//이것저것 사용할수록 프로토콜이 많아질텐데, extenstion을 활용하여 분리할 수 있음

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //열거형을 caseiterable을 넣었기 때문에 모든 케이스를 컬랙션 형태로 가져올 수 있게 되었다.
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell ()
        }
        
        cell.iconImageView.backgroundColor = .systemPink
        cell.titleLable.text = settingList[indexPath.section][indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingSection.allCases[section].description
    }
    
}
