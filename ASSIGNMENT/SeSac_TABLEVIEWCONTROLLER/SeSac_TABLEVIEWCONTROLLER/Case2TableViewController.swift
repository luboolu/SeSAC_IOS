//
//  Case2TableViewController.swift
//  SeSac_TABLEVIEWCONTROLLER
//
//  Created by 김진영 on 2021/10/12.
//

import UIKit

class Case2TableViewController: UITableViewController {

    let headerList: [String] = ["전체 설정", "개인 설정", "기타"]
    let cellList: [[String]] = [["공지사항", "실험실", "버전 정보"],["개인/보안", "알림", "채팅", "멀티프로필"],["고객센터/도움말"]]
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "설정"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        print(cellList)
    }

    //옵션: 섹션의 수 : numberOfSections로 호출
    //사용하지 않으면 default인 1로 설정됨
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerList.count
    }
    
    //numberOfRowsInSection으로 호출
    //이걸 정의 안했더니 셀이 보이지 않았음
    //각 section에 cell이 몇개 들어갈지를 반환해주면, 셀이 생긴다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellList[section].count
    }
    
    //옵션: 섹션 타이틀 : titleForHeaderInSection로 호출
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //헤더가 있을수도 없을수도 있기 때문에 String?으로...
        return headerList[section]
    }
    
    //2. 셀의 디자인 및 데이터 처리
    //cellForRowAt 이걸로 검색
    //재사용 메커니즘, 옵셔널 체이닝, 옵셔널 바인딩

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") else {
                    //nil값이라면 빈 셀을 반환하고 이 이후의 코드는 실행되지 않는다.
                    return UITableViewCell()
                }
        
        cell.textLabel?.text = cellList[indexPath.section][indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 13)
        
        
        return cell
    }
    
    //3. (옵션) 셀의 높이 : default 44 - 옵션이지만 거의 필수로 작성해주어야 함
    //heightForRowAt 이걸로 검색
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
