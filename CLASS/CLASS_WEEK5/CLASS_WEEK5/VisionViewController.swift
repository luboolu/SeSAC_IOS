//
//  VisionViewController.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/27.
//

import UIKit
import JGProgressHUD


/*
카메라: 시뮬레이터 테스트 불가능 -> 런타일 오류 발생
 import ImagePickerViewController -> PHPickerViewController(iOS 14 +) 새로운것 등장
 iOS14+: 선택 접근 권한이 추가됨 + UI(여러개 선택 등등)
 */
class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //언제 show, de
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        print(#function)
        
        self.progress.show(in: view, animated: true)
        VisionAPIManager.shared.fecthFaceData(image: postImageView.image!) { code, json in
            print(json)
            
            self.progress.dismiss(animated: true)
        }
        
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension VisionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //사진을 촬영하거나, 갤러리에서 사진을 선택한 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        //1. 선택한 사진 가져오기
        //allowEditing false -> editedImage = nil
        //allowEditing ture -> editingImage / originalImage
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //2. 로직: 이미지뷰에 선택한 사진 보여주기
            postImageView.image = value
        }
        
        //3. picker dismiss
        picker.dismiss(animated: true, completion: nil)
    }
    //사진을 촬영해야 하는데 취소 버튼을 누른 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}
