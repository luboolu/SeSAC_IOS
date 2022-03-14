//
//  MemoSearchViewController.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/11.
//

import UIKit
import RealmSwift

class MemoSearchViewController: UIViewController {
    
    static let identifier = "MemoSearchViewController"

    @IBOutlet weak var tableView: UITableView!
    
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserMemoList>!
    var fixedTasks: Results<UserMemoList>!
    var searchText: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView NIB 등록
        tableView.register(UINib(nibName: "MemoTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MemoTableViewHeader")
        
        tasks = localRealm.objects(UserMemoList.self).sorted(byKeyPath: "date", ascending: false)
        
        fixedTasks = localRealm.objects(UserMemoList.self).filter("isFixed == true").sorted(byKeyPath: "date", ascending: false)
        

    }
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func convertDateToLocalTime(_ date: Date) -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))

        return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
    }
}

extension MemoSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoTableViewHeader.identifier) as? MemoTableViewHeader else {
            return UITableViewHeaderFooterView()
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let price = tasks.count
        let result = numberFormatter.string(for: price)!
        
        header.headerLabel.text = "\(result)개 찾음"
        header.headerLabel.font = UIFont().binggraeBold
        header.headerLabel.textColor = .black
        
        return header

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //왼쪽 스와이프 - 메모 고정 기능
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fix = UIContextualAction(style: .normal, title: "fix") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let task = self.tasks[indexPath.row]
            
            if task.isFixed == true {
                try! self.localRealm.write {
                    
                    self.localRealm.create(UserMemoList.self, value: ["_id": task._id, "isFixed": false], update: .modified)
                    
                    self.reloadView()
                    
                }
            } else {
                //지금 메모를 고정하려는 경우
                
                //일반 메모 섹션에서 일어난 것 이므로 isFixed: false -> true
                //fixedTasks의 갯수가 5개 미만일때만 고정
                if self.fixedTasks.count < 5 {
                    
                    let task = self.tasks[indexPath.row]
                    
                    try! self.localRealm.write {
                        
                        self.localRealm.create(UserMemoList.self, value: ["_id": task._id, "isFixed": true], update: .modified)
                        
                        self.reloadView()
                        
                    }
                    
                } else {
                    print("고정 기능은 최대 5개까지 가능합니다")
                    let alert = UIAlertController().alertFixOver
                    self.present(alert, animated: false, completion: nil)
                }
                
            }
            
        }
        fix.image = UIImage(systemName: "pin.fill")
        fix.backgroundColor = UIColor(named: "MemoOrange")
        
        return UISwipeActionsConfiguration(actions:[fix])
    }
    
    //오른쪽 스와이프 - 삭제 기능
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "확인", message: "정말 메모를 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "네", style: .default) {
                (action) in
                
                try! self.localRealm.write {
                    self.localRealm.delete(self.tasks[indexPath.row])
                    self.reloadView()
                }
                
            }
            let cancelAction = UIAlertAction(title: "아니요", style: .default, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            
            self.present(alert, animated: false, completion: nil)


            success(true)
            
        }
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = UIColor(named: "MemoRed")
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        let storyBoard = UIStoryboard(name: "MemoAdd", bundle: nil)
        
        guard let vc = storyBoard.instantiateViewController(withIdentifier: MemoAddViewController.identifier) as? MemoAddViewController else { return }
        

        vc.task = tasks[indexPath.row]

        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        //검색된 단어를 다른 색상으로 표현해주기 위한 arrtibute
        let title = NSMutableAttributedString(string: row.title)
        let content = NSMutableAttributedString(string: row.content)
        
        title.addAttribute(.foregroundColor, value: UIColor(named: "MemoOrange"), range: (row.title as NSString).range(of: self.searchText))
        content.addAttribute(.foregroundColor, value: UIColor(named: "MemoOrange"), range: (row.content as NSString).range(of: self.searchText))
        
        
        cell.title.attributedText = title
        cell.title.font = UIFont().binggraeBoldSmall
        
        cell.content.attributedText = content
        cell.content.font = UIFont().binggrae
        
        //date formatter 선택
        let now = convertDateToLocalTime(Date())
        let startWeek = convertDateToLocalTime(now.startOfWeek!)
        let memoDate = convertDateToLocalTime(row.date)
        
        
        var day = Calendar.current
        day.locale = Locale(identifier: "ko_KR")
        day.timeZone = TimeZone(abbreviation: "KST")!
        
        //let today = day.isDateInToday(memoDate)
        let today = day.isDate(memoDate, inSameDayAs: now)
        
        if today {
            let date = DateFormatter.todayFormat.string(from: row.date)
            cell.date.text = date
        } else if startWeek < memoDate {
            let date = DateFormatter.thisWeekFormat.string(from: row.date)
            cell.date.text = date
        } else {
            let date = DateFormatter.defaultFormat.string(from: row.date)
            cell.date.text = date
        }
        
        cell.date.font = UIFont().binggrae
        
        return cell
        
    }
    
    
}

extension MemoSearchViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        
        if let text = searchController.searchBar.text {
            
            tasks = localRealm.objects(UserMemoList.self).filter("content CONTAINS '\(text)' or title CONTAINS '\(text)'")
            
            //검색어 입력 도중 ResultTableView가 갱신되지 않게함
            if tasks.count > 0 {
                self.searchText = text
                tableView.reloadData()
            }
            
        }
    }
    
    
    
}



