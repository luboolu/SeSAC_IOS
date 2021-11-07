//
//  SettingViewController.swift
//  SeSAC_MYSHOPPINGLIST
//
//  Created by 김진영 on 2021/11/06.
//

import UIKit
import Zip


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
        let fileName = 
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
    

}
