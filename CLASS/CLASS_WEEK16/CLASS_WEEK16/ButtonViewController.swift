//
//  ButtonViewController.swift
//  CLASS_WEEK16
//
//  Created by 김진영 on 2022/01/13.
//

import UIKit

class ButtonViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
            button.center = view.center
            button.configurationUpdateHandler = { btn in
                if btn.isHighlighted {
                    btn.tintColor = .black
                }
            }
            view.addSubview(button)
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            button.configuration = .jackStyle()
        }
        
        
        dateFormatStyle()
        numberFormatStyle()
        print(deferExample3())
    }
    
    func deferExample() -> String {
        var nickname = "고래밥"
        
        //defer는 스코프의 끝에서 실행된다! - 그렇기 때문에 바뀌기 전의 값으로 return 됨
        //리턴값을 주고 메모리를 정리하고 싶은 경우
        defer {
            print("defer")
            nickname = "묘미"
        }

        return nickname
    }
    
    func deferExample2() -> String {
        var nickname: String? = "고래밥"
        
        defer {
            nickname = nil
        }
        
        return nickname ?? ""
    }
    
    func deferExample3() {

        //defer가 여러개인 경우에는, 나중에 선언한게 먼저 실행된다!
        defer {
            print("example1")
        }
        
        defer {
            print("example2")
        }
        
        defer {
            print("example3")
        }
        

    }
    
    func dateFormatStyle() {
        let value = Date()
        
        print(value)
        print(value.formatted())
        print(value.formatted(date: .omitted, time: .shortened))
        print(value.formatted(date: .complete, time: .shortened))
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.selectedDetentIdentifier = .medium
        }
        
        view.backgroundColor = color
    }
    
    func numberFormatStyle() {
        print(50.formatted(.percent))
        print(332435134.formatted())
        
        let result = ["올라프", "묵돌이", "뽀로로"].formatted()
        print(result)
    }
    
    @objc func buttonClicked() {

        
        let vc = ChatViewController()

        if let presentationViewController = vc.presentationController as? UISheetPresentationController {
            presentationViewController.detents = [.medium(), .large()]
            presentationViewController.prefersGrabberVisible = true
        }


        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func buttonClicked2() {
        
        let picker = UIColorPickerViewController()
        picker.delegate = self
        
        if let presentationViewController = picker.presentationController as? UISheetPresentationController {
            presentationViewController.detents = [.medium(), .large()]
            presentationViewController.prefersGrabberVisible = true
            presentationViewController.preferredCornerRadius = 10
            
        }
        
        self.present(picker, animated: true, completion: nil)
        
    }
    


}

extension UIButton.Configuration {
    static func jackStyle() -> UIButton.Configuration {
        //UIButton Configuration - iOS 15 이상 가능
        var configuration = UIButton.Configuration.filled()
        configuration.title = "SeSAC"
        configuration.subtitle = "로그인 없이 둘러보기"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .systemRed
        configuration.image = UIImage(systemName: "star.fill")
        configuration.imagePlacement = .trailing
        configuration.cornerStyle = .capsule
        configuration.showsActivityIndicator = true
        
        return configuration
    }
}
