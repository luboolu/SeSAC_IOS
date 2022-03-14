import Foundation
import UIKit
import Security

class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
}

//멤버와이즈 이니셜라이저와 자체 이니셜라이저를 모두 사용하고 싶다면
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






/*
 2021.11.09
 */

//프로토콜 초기화 구문
//어떤 기능을 할지 모르는 상태에서 만드는 것
//protocol Jack {
//    //getter, setter -> 값을 쓰게 할지, 읽게 할지
//    //func welcome()
//
//    init()
//
//}
//
//class Hello: Jack {
//
//
//
////    func welcome() {
////        print("") //메서드에서 실질적인 동작 내용은 여기서 정의해준다.
////    }
//
//    required init() { //초기화 구문이 protocol에서 왔음을 알려주는 키워드 'required'
//
//    }
//
//
//}
//
//
//class HelloBrither: Hello {
//
//    required init() {//그대로 상속받는다.
//
//    }
//
//}


class Hello {
    init() {
        print("Hello")
    }
}

class HelloBtother: Hello {
    override init() {
        print("HelloBrother")
    }
}

let hello = HelloBtother()


//초기화 구문 델리게이션
class A {
    var value: Int
    
    init() {
        self.value = 10
        print("A")
    }
}

class B: A {
    
    override init() {
        super.init()
        print("B")
    }
}

class C: B {
    
    override init() {
        super.init()
        print("C")
    }
    
    deinit {
        print("deinit")
    }
}

var test: C? = C()
test = nil



//에러컨트롤

//영진원API: 20211021, "", "문자", "20211021"

func checkDateFormay(text: String) -> Bool {
    
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    
    return format.date(from: text) == nil ? false : true
    
}

func validateUserInput(text: String) -> Bool {
    //사용자가 입력한 값이 빈 값인 경우
    guard !(text.isEmpty) else {
        print("빈 값입니다.")
        return false
    }
    
    //사용자가 입력한 값이 숫자인지 아닍
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    //사용자가 입력한 값이 날짜 형태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormay(text: text) else {
        print("날짜 형태가 아닙니다.")
        return false
    }
    
    return true
}

if validateUserInput(text: "20220000") {
    print("검색을 할 수 있음")
} else {
    print("검색을 할 수 없음")
}

//-------------------------------------------------------
//오류 처리 패턴
enum ValidationError: Error {
    case emptyString
    case invalidInt
    case invalidDate
}

func validateUserInputError(text: String) throws -> Bool {
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.invalidInt
    }
    
    guard checkDateFormay(text: text) else {
        throw ValidationError.invalidDate
    }
    
    return true
}

do {
    let result = try validateUserInput(text: "20211101")
} catch ValidationError.emptyString{
    print("값이 비어있습니다.")
} catch ValidationError.invalidInt {
    print("숫자 값이 아닙니다.")
} catch ValidationError.invalidDate {
    print("날짜 값이 아닙니다.")
}

//똑같은 형태
do {
    let result2 = try validateUserInput(text: "20211101")
} catch {
    
    switch error {
    case ValidationError.emptyString: print("값이 비어있습니다.")
    case ValidationError.invalidDate: print("날짜 값이 아닙니다.")
    case ValidationError.invalidInt: print("숫자 값이 아닙니다.")
    default:
        print("에러")
    }
    
    print("값이 비어있습니다.")
}


let r = try! validateUserInput(text: "20211101")
let r2 = try? validateUserInput(text: "20211101")
