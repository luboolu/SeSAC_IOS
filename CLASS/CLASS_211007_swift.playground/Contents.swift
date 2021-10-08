import UIKit



class Monster{

    var clothes: String
    var speed: Int
    var power: Int
    var exp: Double

    init(clothes: String, speed: Int, power: Int, exp: Double){
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.exp = exp
    }
    
    func attack(){
        print("몬스터 공격!")
    }

}

var easyMonster = Monster(clothes: "orange", speed: 1, power: 10, exp: 50.0)

easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.exp

var hardMonster = Monster(clothes: "Blue", speed: 10, power: 500, exp: 10000)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.exp


//struct MonsterStruct{
//    //구조체는 init을 만들지 않았지만 자동으로 만들어져서 초기화가 되게 됨
//    //클래스와 달리 구조체는 초기화 구문을 제공해준다 --> 멤버와이즈 초기화 구문 제공
//    var clothes: String
//    var speed: Int
//    var power: Int
//    var exp: Double
//
//
//
//}
//
//var easyMonster = MonsterStruct(clothes: "orange", speed: 1, power: 10, exp: 50.0)
//
//easyMonster.clothes
//easyMonster.speed
//easyMonster.power
//easyMonster.exp
//
//var hardMonster = MonsterStruct(clothes: "Blue", speed: 10, power: 500, exp: 10000)
//hardMonster.clothes
//hardMonster.speed
//hardMonster.power
//hardMonster.exp


//클래스는 상속이 가능합니다. override 재정의
//Monster: 부모클래스(SuperClass), BossMonster: 자식클래스(SubClass)
class BossMonster: Monster{
    
    var bossName = "끝판왕보스"
    
    func bossUniqueAttack(){
        print("보스만의 강력한 공격")
    }
    
    override func attack() {
        super.attack()//부모 클래스의 함수를 사용하고 싶을때
        
        print("보스 공격!!")
    }
    
}

var boss = BossMonster(clothes: "Black", speed: 100, power: 500000, exp: 2000000)
boss.bossName
boss.clothes
boss.power
boss.speed
boss.exp
boss.exp
boss.attack()

//Value Type vs Reference Type
var nickname: String = "고래밥"

var subNickname = nickname


nickname = "칙촉"

print(nickname)
print(subNickname)

class SuperBoss {
    var name: String
    var level: Int
    var power: Int
    
    init(name: String, level: Int, power: Int){
        self.name = name
        self.level = level
        self.power = power
    }
}

var hardStepBoss = SuperBoss(name: "쉬운 보스", level: 1, power: 10)

var easyStepBoss = hardStepBoss

hardStepBoss.power = 50000
hardStepBoss.level = 100
hardStepBoss.name = "어려운 보스"

print(hardStepBoss.name, hardStepBoss.level, hardStepBoss.power)
print(easyStepBoss.name, easyStepBoss.level, easyStepBoss.power)



//211008 수업
//함수 매개변수 반환값 사용

func sayHello() -> String { // -> Void 반환값 표시는 swift3 이후로 생략 가능하게 됨
    
    print("안녕하세요")
    
    return "안녕하세요 반갑습니다!"
    
}

print("자기소개: \(sayHello() )")

func bmi() ->Double {
    
    //조건문 사용하여..해봤으니깐 생략
    
    return 20.1
    
}


func bmiResult() -> [String] {
    
    let name = "고래밥"
    let result = "정상"
    
    return [name, result]
    
}

let value = bmiResult()

print(value[0], "님의 bmi 수치는 ", value[1], "입니다.")


//컬렉션(집단 자료형) : 배열, 딕셔너리, 집합, 튜플

let userInfo = ("고래밥", "jack@jack.com", true, 4,5)

print(userInfo.0)
print(userInfo.1)

//전체 영화 갯수, 전체 러닝타임 한번에 반환
func getMoviewReport() -> (Int, Int) {
    return (1000, 30000)
}

print(getMoviewReport())



//swift5.1 이상 부터 return 키워드 생략 가능, 함수 안에 return 문 이외에 아무것도 없는 경우
//@discardableResult: 반환값을 무시하는 경우, 반환값을 사용하지 않을때 뜨는 경고를 무시하게 할 수 있음
@discardableResult
func getMoviewReport2() -> (Int, Int) {
    (1000, 30000)
}

getMoviewReport2()



//열거형 - 오류에 대한 가능성을 낮춰줌
enum AppleDevice {
    case iPhone
    case iPad
    case watch
}

enum GameJob {
    case rogue //도적
    case warrior //전사
    case mystic //도사
    case shaman //주술사
    case fight //격투가
}

let selectJob: GameJob = GameJob.mystic

if selectJob == .mystic {
    print("당신은 도사입니다.")
} else if selectJob == .shaman {
    print("당신은 주술사입니다.")
}

enum Gender {
    case man, woman
}

enum HTTPCode: Int {
    case Ok = 200
    case SERVER_ERROR = 500
    case NO_PAGE
    
    func showStatus() ->String {
        switch self {
        case .NO_PAGE:
            return "잘못된 주소입니다."
        case .SERVER_ERROR:
            return "서버 점검중입닌다. 서버에 문제가 생겨서 잠시 후 시도해주세요."
        case .Ok:
            return "정상입니다."

        }
        
    }
}

var status: HTTPCode = .NO_PAGE

print(status.rawValue) //원시값

status.showStatus()
