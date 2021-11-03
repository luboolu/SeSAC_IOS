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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchResultTableView.reloadData()
    }
    
    //도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage로 변환 -> UIImageView에 보여주기
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        //AddViewController의 saveButtonClicked와 같은 구조
        
        //1. 이미지를 저장할 경로 설정: document 폴더 -> FileManager 사용
        // Desktop/jack/ios/folder 도큐먼트 폴더의 경로는 계속 변하기 때문에 앙래와 같은 형태로 접근해야 한다.
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        
        //2. 이미지 파일 이름
        //Desktop/jack/ios/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        //4-1. 이미지 경로 여부 확인 (이미 존재한다면 어떻게 할지)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            //4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제 실패")
            }
        }
        
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    //본래는 화면 전환 + 값 전달 후 새로운 화면에서 수정이 적합
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToUpdate = tasks[indexPath.row]
        
        //1. 수정 - 레코드에 대한 값 수정
//        try! localRealm.write {
//            taskToUpdate.diaryTitle = "새롭게 수정해봅니다."
//            taskToUpdate.content = "전기차 판매량에서 현대 아이오닉이 테슬라를 앞질렀다."
//
//            tableView.reloadData()
//        }
        
        //2. 한번에 모든 셀의 데이터를 바꿈
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "writeDate")
//            tasks.setValue("새롭게 일기쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        //3. 수정: PK 기준으로 수정할 때 사용 (권장 x) -> 실행해보면 contents도 다 사라진다
//        try! localRealm.write {
//            let update = UserDiary(value: ["_id" : taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어!"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        //4, 3번에서 contents가 사라지지 않게 함
        try! localRealm.write {
            localRealm.create(UserDiary.self, value: ["_id" : taskToUpdate._id, "diaryTitle" : "예만 바꿀래!"], update: .modified)
            tableView.reloadData()
        }
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
        cell.searchImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).png")


        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        try! localRealm.write {
            deleteImageFromDocumentDirectory(imageName: "\(tasks[indexPath.row]._id).png")
            localRealm.delete(tasks[indexPath.row]) //realm이 먼저 지워지면 위험할 수 있다.
            tableView.reloadData()
        }
    }
    
    
}
