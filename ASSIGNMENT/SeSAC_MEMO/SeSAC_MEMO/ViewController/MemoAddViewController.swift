//
//  MemoAddViewController.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/09.
//

import UIKit
import RealmSwift
import MobileCoreServices

class MemoAddViewController: UIViewController {
    
    static let identifier = "MemoAddViewController"
    
    var task: UserMemoList! //Edit인 경우에 전달
    
    let localRealm = try! Realm()

    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "MemoOrange")

        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonClicked))
        shareButton.tintColor = UIColor(named: "MemoOrange")
        
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
        completeButton.tintColor = UIColor(named: "MemoOrange")
        
        navigationItem.rightBarButtonItems = [shareButton, completeButton]

        
        
        if task != nil {
            self.memoTextView.text = [task.title, task.content].joined(separator: "\n")
        }
        
        self.memoTextView.clipsToBounds = true
        self.memoTextView.layer.cornerRadius = 10
        
        self.memoTextView.font = UIFont().binggraeMedium
        self.memoTextView.textColor = .black
        


    }
    
    @objc func closeButtonClicked() {
        print(#function)
        if self.task != nil {
            self.navigationController?.popViewController( animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func shareButtonClicked() {
        print(#function)
        
        let vc = UIActivityViewController(activityItems: ["\(memoTextView.text!)"], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        
        if let text = memoTextView.text {
            //print(text.split(separator: "\n").first)
            var memo = text.split(separator: "\n")
            
            if memo.count > 0 {
                
                if self.task != nil {
                    let title = String(memo.first!)
                    memo.remove(at: 0)
                    let content = memo.joined(separator: "\n")
                    

                    try! localRealm.write {
                        self.localRealm.create(UserMemoList.self, value: ["_id": self.task._id, "title": title, "content": content, "date": Date()], update: .modified)
                    }
                    
                    
                } else {
                    let title = String(memo.first!)
                    memo.remove(at: 0)
                    let content = memo.joined(separator: "\n")
                    
                    let task = UserMemoList(title: title, content: content, isFixed: false, date: Date())
                    
                    try! localRealm.write {
                        localRealm.add(task)
                    }
                }


            }
            if self.task != nil {
                self.navigationController?.popViewController( animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    
    

    
    


}
