//
//  ViewController.swift
//  CLASS_WEEK16
//
//  Created by 김진영 on 2022/01/10.
//

import UIKit

protocol myProtocol: AnyObject {
    
}

enum GameJob {
    case warrior
    case rogue
}

class Game {
    var level = 5
    var name = "도사"
    var job: GameJob = .warrior
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aboutForeach()
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func textfieldClicked(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        print(#function)
    }
    
    //AnyObject vs Any
    //런타임 시점에 타입이 결정 --> 런타임 오류
    //컴파일 시점에서 알 수 없음
    //Any: Class, Struct, Enum, Closuer ... 모든 타입을 받을 수 있음
    //AnyObject: Class 타입만 가질 수 있음
    func aboutAny() {
        
        let name = "고래밥"
        let gender = false
        let age = 10
        
        let anylist: [Any] = [name, gender, age]
        print(anylist)
        
        if let value = anylist[0] as? String {
            print(value)
        }
        
    }
    
    //수정되지 전까지는 원본을 공유 -> 복사(collection type
    func copyOnWrite() {
//        var nickname = "jack"
//        print(address(of: &nickname))
//        var nicknameByFamily = nickname
//        print(address(of: &nicknameByFamily))
//
//
//        nicknameByFamily = "꽁"
//        print(address(of: &nicknameByFamily))
//        print(nickname, nicknameByFamily)
        
        var array = Array(repeating: 100, count: 100)
        print(address(of: &array))
        
        var newArray = array
        print(address(of: &newArray))
        
        newArray[0] = 0
        print(address(of: &newArray))
        
        var game = Game()
        
        var newGame = game
        newGame.level = 595
        print(game.level, newGame.level)
        
    }
    
    func address(of Object: UnsafeRawPointer) -> String {
        let address = Int(bitPattern: Object)
        return String(format: "%p", address)
    }
    
    
    //collectionType: collection, sequence, subscript
    func aboutSubscript() {
        
        let array = [1,2,3,4,5]
        
        array[2] //결과: 3
        
        let dic = ["도시": 595, "도적": 594]
        dic["도사"]
        
        let str = "Hello world"
        str[0] //subscript를 직접 만들어주면, 다른 것 처럼 접근할 수 있다
        
        
        struct UserPhone {
            var numbers = ["01012341234", "01099998888"]
            
            subscript(idx: Int) -> String {
                get {
                    return self.numbers[idx]
                }
                
                set {
                    self.numbers[idx] = newValue
                }
            }
        }
        
        var value = UserPhone()
        print(value[0])
        value[1] = "1234"
        print(value[1])
        
    }
    
    func aboutForeach() {
        //break, continue
        let array = [1,2,3,4,5,6,7,8,9]
//        for i in array {
//
//            if i == 5 {
//                break
//            }
//            print(i)
//        }
//
        array.forEach { i in
            print(i)
            return
            
        }
    }
    
    //라이브러리, 프레임워크
    //@frozen: 4.2 컴파일, 최적화
    //Unfrozen Enumeration: 계속 추가될 수 있는 가능성을 가진 열거형
    //@unkown: dafaul
    func aboutEnum() {
        
        let size = UIUserInterfaceSizeClass.compact
//        
//        switch size {
//        case .unspecified:
//            <#code#>
//        case .compact:
//            <#code#>
//        case .regular:
//            <#code#>
//        @unknown default:
//            <#fatalError()#>
//        }
        
    }
    

}

extension String {
    
    subscript(idx: Int) -> String? {
        get {
            guard (0..<count).contains(idx) else {
                return nil
            }
            
            let result = index(startIndex, offsetBy: idx)
            return String(self[result])
        }

    }
}

