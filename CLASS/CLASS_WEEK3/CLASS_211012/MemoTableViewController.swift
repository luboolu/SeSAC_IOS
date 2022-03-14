//
//  MemoTableViewController.swift
//  CLASS_211012
//
//  Created by 김진영 on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {

    
//    var list = [Memo]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    //위 아래 모두 같은 선언! 방법만 다르다
    
    var list: [Memo] = [] {
        didSet {
            saveDate()
        }
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults 초기화
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        loadData()
        //UITableView.automaticDimension 찾아보기

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        //배열에 텍스트뷰의 텍스트 값 추가
        if let text = memoTextView.text {
            
            let segmentIndex = categorySegmentControl.selectedSegmentIndex
            let segmentCategory = Category(rawValue: segmentIndex) ?? .others

            let memo = Memo(content: text, category: segmentCategory)
            list.append(memo)
            //tableView.reloadData()
        } else {
            print("")
        }
 
    }
    
    func loadData() {
        
        let userDefualts = UserDefaults.standard
        
        if let data = userDefualts.object(forKey: "memoList") as? [[String:Any]] {
            
            var memo = [Memo]()
            
            for datum in data {
                
                guard let category = datum["category"] as? Int else { return }
                guard let content = datum["content"] as? String else { return }
                
                let enumCatagory = Category(rawValue: category) ?? .others
                
                
                memo.append(Memo(content: content, category: enumCatagory))
                
            }
            
            self.list = memo
        }
    }
    
    func saveDate() {
        var memo: [[String:Any]] = []
        
        for i in list {
            
            let data: [String:Any] = [
                "category": i.category.rawValue,
                "content": i.content
            ]

            memo.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(memo, forKey: "memoList")
        
        tableView.reloadData()
    }
    
    
    //옵션: 섹션의 수 : numberOfSections로 호출
    //사용하지 않으면 default인 1로 설정됨
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //옵션: 섹션 타이틀 : titleForHeaderInSection로 호출
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //헤더가 있을수도 없을수도 있기 때문에 String?으로...
        
        return "섹션 타이틀"
    }
    
    
    //1. 셀의 갯수
    //table view에 있는 함수를 재정의
    //numberOfRowsInSection 이걸로 검색
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //각 섹션에 따라 다르게 적용할수있음
//        if section == 0 {
//            return 2
//        } else {
//            return 4
//        }
            
        //삼항 연산자 사용
        return section == 0 ? 2 : list.count
        
        //셀이 n개 필요하다
    }
    
    //2. 셀의 디자인 및 데이터 처리
    //cellForRowAt 이걸로 검색
    //재사용 메커니즘, 옵셔널 체이닝, 옵셔널 바인딩
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(#function)
        
        //옵셔널 바인딩
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
//            //nil값이라면 빈 셀을 반환하고 이 이후의 코드는 실행되지 않는다.
//            return UITableViewCell()
//        }
        
        //옵셔널 체이닝
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell")
        
        //섹션에 따라 다른 디자인 주기
        if indexPath.section == 0 {
            cell?.textLabel?.text = "첫번째 섹션입니다! - \(indexPath)"
            cell?.textLabel?.textColor = .brown
            cell?.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell?.detailTextLabel?.text = "첫번째 섹션의 detail"
            cell?.imageView?.image = UIImage(systemName: "pencil")
        } else {
            
            let row = list[indexPath.row]
            print(row)
            
            //if문 여러개 만들지 않고, [indexPath.row]를 사용하여 각각 다른 데이터를 넣어줄 수 있음
            cell?.textLabel?.text = row.content
            cell?.detailTextLabel?.text = row.category.description
            cell?.textLabel?.textColor = .blue
            cell?.textLabel?.font = .italicSystemFont(ofSize: 13)

            switch row.category {
            case .business: cell?.imageView?.image = UIImage(systemName: "building.2")
            case .personal: cell?.imageView?.image = UIImage(systemName: "person")
            case .others: cell?.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
            
        }
        return cell!
    }

    
    //3. (옵션) 셀의 높이 : default 44 - 옵션이지만 거의 필수로 작성해주어야 함
    //heightForRowAt 이걸로 검색
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 44 : 80
    }
    
    //(옵션) 셀을 클릭했을때 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택!")
    }
    
    //(옵션) 셀 스와이프 On/Off 여부 : canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    //옵션 : 셀 스와이프 기능으로 delete editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if editingStyle == .delete {
                list.remove(at: indexPath.row)
                //tableView.reloadData()
            }
        }
        
    }
    
    
}
