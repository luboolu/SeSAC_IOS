//: [Previous](@previous)

import Foundation
//
//func makeIncrementer(forIncrement amount: Int) {
//
//    var runningTotal = 0
//
//    func incrementer() -> Int {
//        runningTotal += amount
//        return runningTotal
//    }
//
//    return incrementer
//
//}
//
//let incrementByTen = makeIncrement

func firstClosure() {
    
    var number = 0
    print("1: \(number)")
    
    let closure: () -> Void = { [number] in
        print("closure: \(number)")
    }
    
    number = 100
    closure()
    print("2: \(number)")
}

firstClosure()

class
