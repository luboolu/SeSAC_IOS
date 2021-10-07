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

