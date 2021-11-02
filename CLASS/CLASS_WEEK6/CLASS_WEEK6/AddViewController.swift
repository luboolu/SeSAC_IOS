//
//  AddViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/02.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    static let identifier = "AddViewController"
    
    let localRealm = try! Realm()
    
    @IBOutlet weak var diaryImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var diaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.title = "일기 작성"
        
        titleTextField.placeholder = "제목을 입력해주세요"
        titleTextField.borderStyle = .none
        titleTextField.backgroundColor = .lightGray
        
        dateButton.backgroundColor = .lightGray
        
        diaryTextView.backgroundColor = .lightGray
        diaryTextView.font = UIFont().mainBlack
        
        print("Realm is loacaed at: ", localRealm.configuration.fileURL!)
        
    ///Users/gimjin-yeong/Library/Developer/CoreSimulator/Devices/323D6275-A8A0-44E0-80CE-AA24BF58B1F4/data/Containers/Data/Application/8C569E90-D0CE-46A2-BD42-449E4211B950/Documents/default.realm

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        
        // Add some tasks
        let task = UserDiary(diaryTitle: titleTextField.text!, content: diaryTextView.text! , writeDate: Date(), regDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)
        }
        
    }
}
