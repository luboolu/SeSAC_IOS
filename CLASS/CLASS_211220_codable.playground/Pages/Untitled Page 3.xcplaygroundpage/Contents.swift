//: [Previous](@previous)

import Foundation

struct User: Encodable {
    var name: String
    var signUpDate: Date
    var age: Int
}

let users: [User] = [
    User(name: "Jack", signUpDate: Date(), age: 33),
    User(name: "Ell", signUpDate: Date(), age: 33),
    User(name: "Lisa", signUpDate: Date(), age: 33)
]

dump(users)

let encode = JSONEncoder()
encode.outputFormatting = .prettyPrinted
encode.dateEncodingStrategy = .iso8601

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "yyyy년 MM월 dd일 EEEE"
encode.dateEncodingStrategy = .formatted(format)


do {
    let jsonData = try JSONEncoder().encode(users)
    
    guard let jsonString = String(data: jsonData, encoding: .utf8) else { fatalError("Failed")}
    
    print(jsonString)
} catch {
    print(error)
}

//: [Next](@next)
