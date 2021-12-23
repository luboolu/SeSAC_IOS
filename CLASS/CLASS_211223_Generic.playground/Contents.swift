import UIKit

var apple = 0
var banana = 3

//input parameter(inout 매개변수)
swap(&apple, &banana)

print(apple, banana)

func swapToInts(a: inout Int, b: inout Int) {
    print(#function)
    let tempA = a
    a = b
    b = tempA
}


func swapToDouble(a: inout Double, b: inout Double) {
    print(#function)
    let tempA = a
    a = b
    b = tempA
}

func swapToString(a: inout String, b: inout String) {
    print(#function)
    let tempA = a
    a = b
    b = tempA
}

var fruit1 = "사과"
var fruit2 = "바나나"

swapToString(a: &fruit1, b: &fruit2)
print(fruit1, fruit2)

//JACKㅣ 타입 파라미터 - 함수 정의 시 타입 X, 함수 호출 시 매개변수 타입으로 대체되는 PlaceHolder / UpperCase


func swapTwoValue<Jack>(a: inout Jack, b: inout Jack) {
    print(#function)
    let tempA = a
    a = b
    b = tempA
}

var test1 = 3.3
var test2 = 6.6

swapTwoValue(a: &test1, b: &test2)
print(test1, test2)



///////////////////////////////////////////

//func total(a: [Int]) -> Int {
//    return a.reduce(0, +)
//}
//
//
//func total(a: [Double]) -> Double {
//    return a.reduce(0, +)
//}
//
//func total(a: [Float]) -> Float {
//    return a.reduce(0, +)
//}
//
////Generic으로 어떻게 바꿀까?
////프로토콜 제약
//func total<T: Numeric>(a: [T]) -> T {
//    return a.reduce(.zero, +)
//}

func total<T: AdditiveArithmetic>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

total(a: [2.3, 3.1])

struct Stack<T> {
    
}








func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

equal(a: 3, b: 4)

class Animal: Equatable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one == two

equal(a: one, b: two)



class Dog: Animal {
    
}

class Cat {
    
}

//화면전환
import UIKit

class ViewController: UIViewController {
    
    func transitionViewControllers<T: UIViewController>(sb: String, vc: T) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vc) as! T
        self.present(vc, animated: true, completion: nil)
    }
}



