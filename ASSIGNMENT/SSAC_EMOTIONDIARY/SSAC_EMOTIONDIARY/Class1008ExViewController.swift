//
//  Class1008ExViewController.swift
//  SSAC_EMOTIONDIARY
//
//  Created by 김진영 on 2021/10/08.
//

import UIKit

class Class1008ExViewController: UIViewController {
    //로컬 알림
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        view.backgroundColor = setBackground()
        
        requstNotificarionAuthorization()
    }
    
    //로컬 알림
    func requstNotificarionAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

            userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                
                if success {
                    self.sendNotification()
                }
            }
    }
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
        
        //언제 보낼지 설정: 1. 간격, 2. 캘린더, 3. 위치
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        //알림 요청
        let request = UNNotificationRequest(identifier: "\(Date())",
                                                        content: notificationContent,
                                                        trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    

    //1. 반환값의 타입을 옵셔널 타입으로 변경 : UIColor -> UIColor?
    //2. 반환된 갓을 강제 해제 random.randomElement()!
    //3. 반환될 값: ?? -- nil이면 들어가는 기본 값을 설정해줌 if 문 처럼
    func setBackground() -> UIColor{
        let randomColor: [UIColor] = [.red, .black, .gray, .purple]
        return randomColor.randomElement()!
        //return randomColor.randomElement() ?? UIColor.yellow
        
    }
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        //let alert = UIAlertController(title: "타이틀 테스트", message: "메시지가 입력되었습니다.", preferredStyle: .alert)
        let alert = UIAlertController(title: "타이틀 테스트", message: "메시지가 입력되었습니다.", preferredStyle: .actionSheet)
        
        //2. UIAlertAction 생성: 버튼들을...
        let ok = UIAlertAction(title: "아이폰!!!", style: .default)
        let ipad = UIAlertAction(title: "아이패드!!!", style: .cancel)
        let watch = UIAlertAction(title: "애플워치!!!", style: .destructive)
        
        //3. 1 + 2
        alert.addAction(ok)
        alert.addAction(ipad)
        alert.addAction(watch)
        
        
        //컬러피커
        //let colorPicker = UIColorPickerViewController()
        
        
        
        //4. present
        //present(colorPicker, animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    

}
