//
//  MemoListViewController.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/08.
//

import UIKit
import RealmSwift
import SwiftUI

class Tutorial {
   static func isFirst() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirst") == nil {
            defaults.set(true, forKey:"isFirst")
            return true
        } else {
            return false
        }
    }
}

class MemoListViewController: UIViewController {
    
    static let identifier = "MemoListViewController"

    
    @IBOutlet weak var memoListLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    let localRealm = try! Realm()
    
    var tasks: Results<UserMemoList>!
    var fixedTasks: Results<UserMemoList>!
    var notFixedTasks: Results<UserMemoList>!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isFirst = Tutorial.isFirst() //앱 첫실행 감지

        if isFirst {
            
            let storyBoard = UIStoryboard(name: "MemoTutorial", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: MemoTutorialViewController.identifier) as! MemoTutorialViewController
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        //Protocol
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView NIB 등록
        tableView.register(UINib(nibName: "MemoTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MemoTableViewHeader")
        
        tasks = localRealm.objects(UserMemoList.self).sorted(byKeyPath: "date", ascending: false)
        fixedTasks = localRealm.objects(UserMemoList.self).filter("isFixed == true").sorted(byKeyPath: "date", ascending: false)
        notFixedTasks = localRealm.objects(UserMemoList.self).filter("isFixed == false").sorted(byKeyPath: "date", ascending: false)
        
        //Realm 파일 위치
        print("Realm is loacaed at: ", localRealm.configuration.fileURL!)
        
        //memoListLabel 설정
        memoListLabelSet()
        

        //search controller
        let storyboard = UIStoryboard(name: "MemoSearch", bundle: nil)
        let resultsController = storyboard.instantiateViewController(withIdentifier: MemoSearchViewController.identifier) as! MemoSearchViewController
        let searchController = UISearchController(searchResultsController: resultsController )
 
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater  = resultsController //searchResultsController를 사용하려면 self가 아니라 데이터를 보여줄 뷰 컨트롤러를 적어줘야함
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        self.reloadView()
    }
    
    func reloadView() {
        memoListLabelSet()
        tableView.reloadData()
    }
    
    func convertDateToLocalTime(_ date: Date) -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))

        return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
    }
    
    func memoListLabelSet() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let price = tasks.count
        let result = numberFormatter.string(for: price)!

        memoListLabel.text = "\(result)개의 메모"
        memoListLabel.font = UIFont().binggraeBoldLarge
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? fixedTasks.count : notFixedTasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //왼쪽 스와이프 - 메모 고정 기능
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fix = UIContextualAction(style: .normal, title: "fix") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            if indexPath.section == 0 {
                //고정 메모 섹션에서 일어난 것 이므로 isFixed: true -> false
                //고정 메모 해제는 기존 고정 메모의 개수가 몇개인지 확인할 필요 X
                let task = self.fixedTasks[indexPath.row]
                
                try! self.localRealm.write {
                    
                    self.localRealm.create(UserMemoList.self, value: ["_id": task._id, "isFixed": false], update: .modified)
                    
                    self.reloadView()
                    
                }
                
            } else {
                //일반 메모 섹션에서 일어난 것 이므로 isFixed: false -> true
                //fixedTasks의 갯수가 5개 미만일때만 고정
                if self.fixedTasks.count < 5 {
                    
                    let task = self.notFixedTasks[indexPath.row]
                    
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
                    if indexPath.section == 0 {
                        self.localRealm.delete(self.fixedTasks[indexPath.row])
                    } else {
                        self.localRealm.delete(self.notFixedTasks[indexPath.row])
                    }
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

        let storyBoard = UIStoryboard(name: "MemoAdd", bundle: nil)
        
        guard let vc = storyBoard.instantiateViewController(withIdentifier: MemoAddViewController.identifier) as? MemoAddViewController else { return }
        
        if indexPath.section == 0 {
            vc.task = fixedTasks[indexPath.row]
        } else {
            vc.task = notFixedTasks[indexPath.row]
        }
        
        //vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {

            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoTableViewHeader.identifier) as? MemoTableViewHeader else {
                return UITableViewHeaderFooterView()
            }
            
            header.headerLabel.text = "고정된 메모"
            header.headerLabel.font = UIFont().binggraeBold
            header.headerLabel.textColor = .black
            
            return header
            
        } else {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoTableViewHeader.identifier) as? MemoTableViewHeader else {
                return UITableViewHeaderFooterView()
            }
            
            header.headerLabel.text = "메모"
            header.headerLabel.font = UIFont().binggraeBold

            header.headerLabel.textColor = .black
            
            return header
            
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            
            let row = fixedTasks[indexPath.row]
            
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

            cell.title.text = row.title
            cell.title.font = UIFont().binggraeBoldSmall
            
            cell.date.font = UIFont().binggrae
            
            cell.content.text = row.content
            cell.date.font = UIFont().binggrae
            
        } else {
            
            let row = notFixedTasks[indexPath.row]
            
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

            cell.title.text = row.title
            cell.title.font = UIFont().binggraeBoldSmall
            
            cell.date.font = UIFont().binggrae
            
            cell.content.text = row.content
            cell.content.font = UIFont().binggrae
        }

        return cell
        
    }
    
    
}


extension MemoListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        self.reloadView()
    }
    
}


