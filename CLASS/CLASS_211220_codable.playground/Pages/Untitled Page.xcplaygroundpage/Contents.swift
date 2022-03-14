import UIKit

//Decoding
let json = """
{
"quote_content": "Your body is made to move so move it.",
"author_name": "Toni Sorenson"
}
"""

//class struct enum
struct Quote: Decodable {
    var quote: String
    //이름이 바뀐다면?!
    //var quoteContent: String
    
    var author: String
    //var authorName: String
    
    //CodingKeys는 이미 정해져있는 프로토콜
    enum CodingKeys: String, CodingKey {
        case quote = "quote_content"
        case author = "author_name"
    }
}

//String -> Data
guard let result = json.data(using: .utf8) else { fatalError("Failed")}

let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
print(result)

//Data -> Quote
do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}

/*
 struct의 변수 이름이 바뀌는 경우 처리하는 방법
 1. Optional
 2. keyDecodeingStrategy = .convertFromSnakeCase
 3. Custom key =
 
 
 */



//swift - Meta Type
//quote의 타입은?
//String의 타입은 String.Type 메타 타입은 클래스 구조체 열거형 등의 유형 자체를 가리킴
let name: String = "jack"
type(of: name)

//Quote: 인스턴스에 대한 타입, Quote 구조체 자체의 타입은 뭐야? Qupte.Type
let quote = Quote(quote: "명언 명언", author: "JACK")
type(of: quote)
print(type(of: quote))

struct User {
    var name = "고래밥"
    static let identifier = 1234567//타입 프로퍼티
}

let user = User()
user.name

User.identifier
User.self.identifier
type(of: user).identifier

User.self.init(name: "hello")

//이를 이용하면 컴파일러가 아니라 런타임때의 타입을 알 수 있다.
let age: Any = 15
type(of: age)
