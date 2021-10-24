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




//21.10.21


/*
 1. 1급 객체
 - 변수나 상수에 함수를 대입할 수 있다.
 
 */

//변수나 상수에 함수를 대입할 수 있다.
func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "신한", "KB"]
    
    return bankArray.contains(bank) ? true : false
}

//변수나 상수에 함수를 실행하고 나온 반환값을 jack에 삽입
let jack = checkBankInformation(bank: "우리") //Bool type


let jackAccount = checkBankInformation //단지 함수만 대입 -> 실행되지 않음
jackAccount("국민") //함수를 호출해야 실행된다

//(String) -> Bool 이게 뭘까? Function Type!

let tupleExample: (Int, Bool, String, Double) = (1, true, "dkd", 3.3)
tupleExample.1

//Function Type 1. (String) -> String
func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다."
}



//Function Type 2. (String, Int) -> String
func hello(nickname: String, userAge: Int) -> String {
    return "저는 \(nickname), \(userAge)세 입니다."
}


//Function Type 3. () -> Void, () -> ()
//typealiase Void = ()
func hello() -> Void {
    print("안녕하세요 반갑습니다.")
}

//함수를 구분하기 힘들때 타입 어노테이션을 통해 함수를 구별할 수 있다. 또는, 함수의 식별자로 구분할 수 있다.(어떤 매개변수가 들어가는지 부분이 식별자)
//힘수의 식별자를 사용한다면, 타입 어노테이션을 생략하더라도 함수를 구별할 수 있다.
let a: (String) -> String = hello(nickname: )
let b: (String, Int) -> String = hello(nickname:userAge: )

//b 상수를 hello처럼 사용할 수 있다.
b("minsu", 33)
b("hello", 28)



//2. 함수의 반환 타입으로 함수를 사용할 수 있다. 구조체 클래스 등 반환값으로 사용할 수 있음
// () -> String
func currentAccount() -> String {
    return "계좌 있음"
}

func noCurrentAccount() -> String {
    return "계좌 없음"
}

//가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBankInformation2(bank: String) -> String {
    let bankArray = ["우리", "신한", "KB"]
    
    return bankArray.contains(bank) ? currentAccount() : noCurrentAccount()
}

let minsu = checkBankInformation2(bank: "농협")


//2-1 Calculate
func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

//가독성을 위해서 가급적 단계를 나눠 작성하는편
let result = calculate(operand: "-")
result(5, 3)

/*
 3. 함수의 인자값으로 함수를 사용할 수 있다.
 콜백 함수로 자주 사용이 됨. 콜백함수: 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수
 */

// () -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func resultNumber(base: Int, odd: () -> (), even: () -> ()) {
    return base.isMultiple(of: 2) ? odd() : even()
}

resultNumber(base: 9, odd: oddNumber, even: evenNumber)

func plusNumber() {
    print("더하기")
}

func minusNumber() {
    print("빼기")
}

//어떤 함수가 들어가는 것과 상관 없이, 단지 타입만 잘 맞으면 된다.
//실질적인 연산은 인자값으로 받는 함수에 달려있어서, 증개 역할만 담당한다고 하여 브로커라고 부른다.
resultNumber(base: 9, odd: plusNumber, even: minusNumber)

resultNumber(base: 9) {
    print("SUCCESS")
} even: {
    print("FAILED")
}

//클로저의 유래...

func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...5))"
    }

    let result = luckyNumber(number: item * 2)

    return result
}

drawingGame(item: 10)//외부 함수의 생명주기 -> 내부 함수의 생명 주기(은닉성)
    
//내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> (Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5))"
    }

    return luckyNumber
}

let luckyNumber2 = drawingGame2(item: 10) //외부 함수는 생명 주기가 끝남

luckyNumber2(2) //외부함수의 생명주기가 끝나더라도 내부함수는 계속 사용할 수 있다.

//은닉성이 있는 내부 함수를 외부 함수의 실행 결과로 반환하면서, 내부 함수를 외부에서도 접근 가능하게 되었음. 이제 얼마든지 호출 가능. 이건 생명 주기에도 영향을 미침. 외부 함수가 종료되더라도 내부 함수는 살아있음.
//드디어 클로저를 봅시다.
//같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨.
//클로저에 의해 내부 함수 주변의 지역 변수나 상수도 함께 저장됨. -> 값이 캡쳐되었다 라고 표현한다.
//주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일대 발생함. 클로져 캡쳐 기본 기능임.

//=> 스위프트는 특히 이름이 없는 함수로 클로저를 사용하고 있고, 주변 환경(내부 함수 주변의 변수나 상수)로부터 값을 캡쳐할 수 있는 "경량 문법"으로 많이 사용하고 있다.


//() -> ()
func studyiOS() {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarder = {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarder2 = { () -> () in
    print("iOS 개발자를 위해 열공중")
}

studyiOSHarder2()

let studyiOSHarder3 = { () -> () in
    print("iOS 개발자를 위해 열공중")
}

studyiOSHarder3()

func getStudyWithMe(study: () -> () ) {
    study()
}

//인라인 클로저
getStudyWithMe(study:  { () -> () in
    print("iOS 개발자를 위해 열공중")
})

getStudyWithMe(study: studyiOSHarder2)

//트레일링 클로저
getStudyWithMe() { () -> () in
    print("iOS 개발자를 위해 열공중")
}

func todayNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

todayNumber(result: { (number: Int) -> String in
    return "행운의 숫자 \(number)"
})

todayNumber(result: { (number) in
    return "행운의 숫자 \(number)"
})

//매개변수가 생략되면 할당된 내부 상수 $0를 사용할 수 있다.
todayNumber(result: {
    return "행운의 숫자 \($0)"
})

todayNumber() { "\($0)" }

todayNumber { value in
    print("하하하")
    return "\(value)입니다."
}


//@autoclousre @escaping : 따로 찾아보기
