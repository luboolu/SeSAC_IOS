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
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
//        let buttonDate = self.dateButton.currentTitle!
//        let value = format.date(from: buttonDate)!
        
//        guard let date = dateButton.currentTitle, let value = format.date(from: date) else { return }
        guard let date = dateButton.currentTitle, let value = DateFormatter.customFormat.date(from: date) else { return } //직접 만들어놓은 extension으로 date formatting
        
        // Add some tasks
        let task = UserDiary(diaryTitle: titleTextField.text!,
                             content: diaryTextView.text!,
                             writeDate: value,
                             regDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).png", image: diaryImageView.image!)
        }
        
    }
    
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        //let alert = UIAlertController(title: "타이틀 테스트", message: "메시지가 입력되었습니다.", preferredStyle: .alert)
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        //Alert Customizing
        //1. 얼럿 안에 들어와서 그런가?
        //2. 스토리보드가 인식이 안되나? DatePickerViewController()
        //3. 스토리보드 씬 + 클래스 -> 화면전환코드
        //let contentView = UIViewController() //코드로 뷰 만들기
        
        //let contentView = DatePickerViewController() //스토리보드로 만든 뷰 컨트롤러 등록 - 스토리보트랑 연결되는게 아니라 클래스만을 가져온것임 그래서 데이터피커가 보이지 않는것
        
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {
            print("DatePickerViewController에 오류가 있음")
            return
        }
        
        //contentView.view.backgroundColor = .green
        contentView.preferredContentSize.height = 200
        alert.setValue(contentView, forKey: "contentViewController")
        //2. UIAlertAction 생성: 버튼들을...
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            //확인 버튼을 눌렀을때 버튼 타이틀 변경
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.myPicker.date)
            self.dateButton.setTitle(value, for: .normal)
        }
        
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        //3. 1 + 2
        alert.addAction(ok)
        alert.addAction(cancel)
        
        //4. present
        self.present(alert, animated: true, completion: nil)

    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        
        //1. 이미지를 저장할 경로 설정: document 폴더 -> FileManager 사용
        // Desktop/jack/ios/folder 도큐먼트 폴더의 경로는 계속 변하기 때문에 앙래와 같은 형태로 접근해야 한다.
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        
        //2. 이미지 파일 이름
        //Desktop/jack/ios/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        //3. (선택) 이미지 압축 image.pngData()
        //guard let data = image.pngData() else { return }
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
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
        
        //5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
            print("이미지 저장 성공")
        } catch {
            print("이미지 저장 실패")
        }
        
        
        
    }
}
