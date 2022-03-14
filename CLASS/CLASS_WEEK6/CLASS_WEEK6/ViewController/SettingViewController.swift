//
//  SettingViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit
import Zip
import MobileCoreServices
/*
 백업하기
 - 사용자의 아이폰 저장 공한 확인
    - 부족: 백업 불가
 - 백업 진행
    - 어떤 데이터도 없는 경우라면 백업할 데이터가 없다고 안내
    - 백업 가능판 파일 여부 확인 realm, folder
    - 백그라운드 기능 또는 Progress + UI 인터렉션 금지(기다려주세요!)
 - 보통은 zip으로 백업 파일을 만듦
    - 백업 완료 시점에
    - Progress + UI 인터렉션 허용
 - 공유 화면 띄워줌
 */

/*
 복구하기
 - 사용자의 아이폰 저장 공간 확인
 - 파일 앱 ( 이 안에 백업 파일이 있는지 확인)
    - zip 파일만 보여주기
    - zip 선택
 - zip -> unzip
    - 백업 파일 이름 확인
    - 업축해제
        - 백업 파일인지 확인: 폴더, 파일 이름
        - 정상적인 파일인가
 - 백업 당시 데이터랑 지금 현재 앱엥서 사용중인 데이터 어떻게 합칠건지에 대한 고려
    - 벡압 데이터 선택
 */

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //1. document 폴더 위치
    func documentDirecroyPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    //7. 백업파일 공유하기
    func presentActivityViewController() {
        //압축 파일 경로 가져오기
        let fileName = (documentDirecroyPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func activityViewControllerButtonClicked(_ sender: UIButton) {
        
        presentActivityViewController()
        
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        print(#function)
        
        //4. 백업할 파일에 대한 URL 배열
        var urlPaths = [URL]()
        
        //1. document 폴더 위치
        if let path = documentDirecroyPath() {
            //2. 백업하고자 하는 파일 URL 확인
            //이미지 같은 경우 백업 편의성을 위해 폴더를 생성하고, 폴더 내에 이미지를 저장하는 것이 효율적
            
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            //2. 백업하고자 하는 파일의 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                //5. URL 배열에 백업 파일 URL 추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다.")
            }
        }
        
        //3. 4번 배열에 대해 압축 파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive")
            print("압축경로: \(zipFilePath)")
            
            presentActivityViewController()
                                                    
        }
        catch {
            print("someting wrong")
        }
        
    }
    
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        //복구1. 파일앱 열기 + 확장자
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    

}

extension SettingViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        //복구 - 2. 선텍힌 핑;ㄹㅇ[ 데힌 경로 가져와야 함
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        //복구 - 3. 압축해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progreess: \(progress)")
                    //복구가 완료되었습니다; 메세지, 얼럿 -> 앱 재시작
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
            
        } else {
            // 파일 앱의 zip -> document 폴더에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progreess: \(progress)")
                    //복구가 완료되었습니다; 메세지, 얼럿 -> 앱 재시작
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
}
