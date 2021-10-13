import UIKit
import Foundation

//옵셔널 바인딩: if - let, guard
enum UserMissonStatus: String {
    case missionFailed = "실패"
    case missionSucceed = "성공"
}

UserMissonStatus.missionFailed.rawValue

func checkNumber(number: Int?) -> (UserMissonStatus, Int?){
    if number != nil {
        return (.missionSucceed, number!)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber2(number: Int?) -> (UserMissonStatus, Int?){
    if let value = number {
        return (.missionSucceed, value)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber3(number: Int?) -> (UserMissonStatus, Int?){
    guard let value = number else {
        return (.missionFailed, nil) //early exit 형태
    }
    
    return (.missionSucceed, value)
}


//타입 캐스팅:  메모리의 인스턴스 타입은 바뀌지 않는다.
let array: [Any] = [1, true, "안녕"]
let arrayInt = array as? [Int]


class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class AppleMobile: Mobile {
    let company: String = "애플"
}

class GoogleMobile: Mobile {
    let company: String = "구글"
}

let mobile = Mobile(name: "PHONE")
let apple = AppleMobile(name: "iPHONE")
let google = GoogleMobile(name: "Galaxy")

mobile is Mobile //클래스 타입이 맞니?
mobile is AppleMobile
mobile is GoogleMobile

apple is Mobile //클래스 타입이 맞니?
apple is AppleMobile
apple is GoogleMobile

let iPhone: Mobile = AppleMobile(name: "iPad")
iPhone.name

if let value = iPhone as? AppleMobile{
    print("성공", value.company)
} else {
    print("실패")
}

//클래스, 구조체
enum DrinkSize {
    case short, tall, grande, venti
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

class DrinkClass{
    let name: String
    var count: Int
    var size: DrinkSize
    
    init(name: String, count: Int, size: DrinkSize){
        self.name = name
        self.count = count
        self.size = size
    }
}

let drinkStruct = DrinkStruct(name: "아메리카노", count: 3, size: .tall)
//drinkStruct.count = 5
//drinkStruct.size = .tall

print(drinkStruct.name, drinkStruct.count, drinkStruct.size)


let drinkClass = DrinkClass(name: "블루베리스무디", count: 2, size: .venti)
drinkClass.count = 5
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)


//지연 저장 프로퍼티
struct Poster {
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
    
    init() {
        print("Poster Initialized")
    }
}

struct MediaInformation {
    var mediaTitle: String
    var mediaRuntime: Int
    //지금 바로 초기화 하는게 아니라 나중에 불러줄때 초기화 할게!!
    lazy var mediaPoster: Poster = Poster()
}

var media = MediaInformation(mediaTitle: "오징어게임", mediaRuntime: 333)
print("1")

media.mediaPoster
print("2")


//연산 프로퍼티 & 프로퍼티 감시자 -> Swift5.1 PropertyWrapper (@Environment) 주로 SwiftUI
//타입 알리어스
class BMI {
    typealias BMIValue = Double //직접 타입 만들기
    //프로퍼티 감시자 - 값이 바뀌는지 안바뀌는지를 감시함
    var userName: String {
        willSet {
            print("닉네임 변경 예정: \(userName) -> \(newValue)")
        }
        didSet {
            changeNameCount += 1
            print("닉네임 뱐걍 결과: \(oldValue) -> \(userName)")
        }
    }
    
    var changeNameCount = 0
    
    var userWeight: BMIValue
    var userHeight: BMIValue
    
    //연산 프로퍼티
    var BMIResult: String {
        get {
            let bmiValue = (userWeight * userHeight) / userHeight
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            
            return "\(userName)님의 BMI 지수는 \(bmiValue)으로, \(bmiStatus)입니다."
        }
        
        set(nickname) {
            userName = nickname
        }
    }
    
    init(userName: String, userWeight: Double, userHeight: Double) {
        self.userName = userName
        self.userWeight = userWeight
        self.userHeight = userHeight
    }
}

let bmi = BMI(userName: "jack", userWeight: 50, userHeight: 160)

let result = bmi.BMIResult

print(result)

bmi.BMIResult = "MINSU"
bmi.BMIResult = "JACKIE"
bmi.BMIResult = "HELLO"
print(bmi.BMIResult)

print(bmi.changeNameCount)



