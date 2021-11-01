//
//  AddViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/02.
//

import UIKit

class AddViewController: UIViewController {
    
    static let identifier = "AddViewController"
    
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

    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonClicked() {
        print(#function)
    }
}
