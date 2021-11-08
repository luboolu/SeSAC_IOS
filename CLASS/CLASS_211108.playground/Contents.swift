import Foundation
import UIKit

class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
}

extension UserStruct {
    init(age: Int) {
        self.name = "손님"
        self.age = age
    }
}

////인스턴스 - 저장 프로퍼티 초기화
let a = User() //초기화 구문, 초기화 메서드 -> Default  Initializer
let b = UserStruct(name: "", age: 9) //멤버와이즈이니셜라이저? Memberwise Initializer
let c = UserStruct()
let d = UserStruct(age: 22)

let color = UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
let color2 = UIColor.init(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
//.init 초기화 메서드 생략 가능

//편의 생성자 convenience initializer
class Coffee {
    let shot: Int
    let size: String
    let menu: String
    let mind: String
    
    init(shot: Int, size: String, menu: String, mind: String) {
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    //기본 2 tall
    convenience init(value: String) {
        self.init(shot: 2, size: "보통", menu: value, mind: "대략정성")
    }
}

let coffee = Coffee(shot: 2, size: "크게", menu: "아아", mind: "정성듬뿍")
let coffee2 = Coffee(value: "뜨아")

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let customColor = UIColor(red: 28, green: 12, blue: 205)
