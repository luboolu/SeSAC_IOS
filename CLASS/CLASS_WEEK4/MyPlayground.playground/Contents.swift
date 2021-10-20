import UIKit
import Foundation

//21.10.18
//Protocol: 클래스나 구조체 기반의 청사진...ex.사장 - 비서
//실질적인 구현은 하지 않기 때문에 {}는 쓰지 않는다
//실질적인 구현은 하지 않는다. 명세만 담당!
//특정 뷰객체

//프로토콜 메서드

//만약 프로토콜을 클래스에서만 사용하도록 제한을 하고 싶다면 annotation을 표기하면 된다. 2가지 방법 있음
//1. protocol OrderSystem: class {} - 문법이 바뀌면서...
//2. protocol OrderSystem: AnyObject {}를 사용하면된다.
@objc
protocol OrderSystem {
    
    func recommandEventMenu()
    //@objc를 붙이면 선택적 구현이 된다.
    @objc func askStampCard(count: Int) -> String
    //init()
    //초기화 구문: 구조체에 멤버와이즈 구문이 있더라도 프로토콜에 초기화 구문이 있다면 무조건 구현해야한다.
    //클래스 같은 경우, 무모 클래스에 초기화 구문과 프로토콜의 초기화 구문이 구별되므로 명시해야한다.-> required initdl vlftnfh emfdjrka
 
}

class StarbucksMenu {
    
    
    
}

//클래스는 단일상속만 가능하다. 확장해서 사용하려면 프로토콜을 사용해야함
//같은 프로토콜의 함수이지만, 틀만 똑같고 실질적인 내용은 다르게 구현할 수 있다

class Smoothie: StarbucksMenu, OrderSystem {
    func recommandEventMenu() {
        print("스무디 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count)잔 적립 완료"
    }

}


class Coffee: StarbucksMenu, OrderSystem {
    
    let smoothie = Smoothie() //비교연산자 is
    
    func test() {
        smoothie is Coffee //False
        smoothie is StarbucksMenu //True
        smoothie is OrderSystem //True, 상속받은 프로토콜로 형변환이 가능하다
    }
    
    func recommandEventMenu() {
        print("커피 베이컨 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }
}

//프로토콜 프로퍼티: 타입과 get, set만 명시, 연산 프로퍼티/저장 프로퍼티는 상관 없음
protocol NavigationUIProtocol {
    var titleString: String { get set } //get set은 읽기 전용으로 쓸지 쓰기 전용으로 쓸지 이런걸 정해줌, get set은 둘 다 할 수 있음
    var mainTintColot: UIColor { get } //get만 사용한 경우, get은 필수, set 선택.
                                    //get, set 을 명시해두면 둘 다 구현해야함
}

class JackViewController: UIViewController, NavigationUIProtocol {
    var titleString: String = "나이 일기" //저장 프로퍼티로 사용
    
    var mainTintColot: UIColor = .black// get만 되도록 했는데, 어떻게 새로 설정할 수 있나?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        view.backgroundColor = mainTintColot
    }
}

class Jack2ViewController: UIViewController, NavigationUIProtocol {
    //연산 프로퍼티로 만들기
    var titleString: String {
        get {
            return "나의 일기"
        }
        set {
            title = newValue
        }
    }
    
    var mainTintColot: UIColor {
        get {
            return .black
        }
        //get만 쓰는 경우는
        //return .black 한줄로 간소화 가능
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleString = "새로운 일기"
        
    }
}

//얀산 프로퍼티
struct SeSACStudent {
    var totalCount = 50
    
    var currentStudent = 0
    
    var studentUpdate: String {
        get {
            return "정원 마감까지 \(totalCount - currentStudent)명 남았습니다."
        }
        set {
            currentStudent += Int(newValue)! //옵셔널 위험하지만 일단 이렇게 설정
        }
    }
}

var sesac = SeSACStudent() //인스턴스 생성, 인스턴스를 let으로 선언하면 그 내용을 바꾸지 못하게 된다. 내용을 바꿀거면 var로 선언

sesac.studentUpdate = "10" //set 실행
 
sesac.studentUpdate //get 실행






//21.10.20

var sample = Array(repeating: "가", count: 100)

sample.count
sample.capacity

sample.append(contentsOf: Array(repeating: "나", count: 100))

sample.count
sample.capacity

var sample2: [Int] = []

for i in 1...200 {
    sample2.append(i)
    sample2.count
    sample2.capacity
}



var str = "Hello World - Hello"
var t = "Squid game".replacingOccurrences(of: " ", with: "_").lowercased()
//-> "Squid_game"

