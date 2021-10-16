import UIKit
import Darwin

//var my = "123s"
//
//
//my.unicodeScalars.allSatisfy(CharacterSet.decimalDigits.contains)
//
//let height:Double = 160
//let weight:Double = 50
//
//print((height + weight) / 100)
//
//my.count
//
//Int("sr")
//
//"".unicodeScalars.allSatisfy(CharacterSet.decimalDigits.contains)


let myString: String = "String"
let myOptionalString: String? = "Optional String"

print("myString: \(myString)")
print("myOptionalString: \(myOptionalString)")

let myForceUnwrappingString = myOptionalString!
print(myForceUnwrappingString)

let myNil: String? = nil

if let myOptionalString: String = myOptionalString {
    print("nil 값이 아님!")
    
} else {
    print("nil 값임!")
}

func guardTest() {
    let myOptionalNum: Int? = 5
    print(myOptionalNum)
    guard let myNum = myOptionalNum else {
        print("nil 값임!")
        return
    }
    print(myNum)

}

guardTest()
