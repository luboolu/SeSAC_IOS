//
//  SettingViewController.swift
//  SeSAC_MYSHOPPINGLIST
//
//  Created by 김진영 on 2021/11/06.
//

import UIKit
import Zip
import MobileCoreServices


//백업,복구 기능 구현하기
class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //1. document 폴더 위치
    func documentDirectoryPath() -> String? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
        
    }
    
    //7. 백업 파일 공유하기
    func presentActivityViewController() {
        //압축파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        //4. 백업할 파일에 대한 URL 배열 -> 배열이므로 여러개의 파일을 넣어 백업 가능
        var urlPaths = [URL]()
        
        //1. document 폴더 위치
        if let path = documentDirectoryPath() {
            //2. 백업하고자 하는 파일 URL 확인
            
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            //2. 백업하고자 하는 파일의 존재 여부 확인 -> 지금은 realm 파일 하나
            if FileManager.default.fileExists(atPath: realm) {
                //5. URL 배열에 백어 파일 URL 추가
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
            print("something wrong")
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
