import UIKit //Foundation Framework
//import Foundation //이라고 해도 문제 없음!

//옵셔널이 아닌 타입으로 선언하여 nil 값이 들어갈 수 없음
//var email: String = "abc@a.com"

//타입 뒤에 ?를 붙이면 옵셔널로 선언이 됨
var email: String? = "abc@a.com"
type(of: email)
var gender: Bool = true // = 할당 연산자

//email = nil

print("회원 정보: \(email), \(gender)")

//옵셔널 언래핑!
if email == nil {
    print("이메일을 잘못 작성하셨습니다.")
} else{
    print(email!) //nil이 아니므로 옵셔널 강제해제
}

//if email != nil {
//    print(email!)
//} else {
//    print("이메일을 잘못 작성하셨씁니다.")
//}

//삼항연산자 if else 문을 줄여줄 수 있음
// ? ㅇㅇ : ㄴㄴ
let result = email != nil ? email! : "이메일을 잘못 작성하셨습니다"
print(result)

//연락처를 기입하는 텍스트필드일 경우, 텍스트 필드에 작성되는 모든 글자는 문자로 인식이 된다. 숫자를 입력하더라도 String
var phoneNumber = "01012341234안녕"
type(of: phoneNumber)
//1.입력된 내용이 숫자가 맞는지? 2.숫자 카운트(유효한 휴대폰 번호 자릿수인지) 3.빈 칸 일 경우
//형 변환 필요!
var resultPhoneNumber = Int(phoneNumber)
type(of: resultPhoneNumber)


Int8.min
Int8.max
UInt8.min
UInt8.max

//집단 자료형 - 배열
var foodList: [String?] = ["도넛", "nil", "아이스크림", "크로플"]
type(of: foodList)

foodList.insert("사탕", at: 1)
foodList.append("초콜릿")
foodList.append(contentsOf: ["와플", "버블티"])


var numberArray = [Int](1...100)
//var numberArray = Array(repeating: 0, count: 100)

//numberArray.shuffle()
//numberArray.shuffled() //~ed, ing: 원본 값은 건들지 않는다.

print(numberArray)

var sortArray = [3,4,5,10,8,1]
sortArray.sort()
sortArray.sorted()


var sampleString = "SSAC"
sampleString.append(": iOS 앱 개발자 데뷔 과정")
print(sampleString)

var sampleString2 = "SSAC"
sampleString2.appending(": iOS 앱 개발자 데뷔 과정")
print(sampleString2)

//집단 자료형 - dict --> key value로 구성, key는 고유해야 함
//배열과 달리 순서가 없음, 출력할 때 마다 순서가 바뀜
//var dictionary: [Int: String] = [1: "김철수", 2: "김안녕", 3: "하하하"]
var dictionary: Dictionary<Int, String> = [1: "김철수", 2: "김안녕", 3: "하하하"]

dictionary[1] //index가 아닌 Key값으로 접근
dictionary[5] = "하윤철"

print(dictionary)


//신조어검색기
let wordDictionary = ["jmt": "존맛탱", "별다줄": "별걸 다 줄인다", "스드메": "스튜디오 드레스 메이크업"]
let wordArray = ["jmt", "별다줄", "스트메"]
let userText = wordArray.randomElement()!
let userSearchText = "JMT".lowercased()

wordDictionary[userSearchText]

if userText == "jmt" {
    print("존맛탱")
}



//집단 자료형 - set 집합
let set: Set<Int> = [1, 3, 4, 5, 5, 6, 7, 7, 7]
let set2: Set<Int> = [2, 3, 4, 4, 4, 4, 4]
print(set) //중복되는 값을 제외하고 고유한 값들만 출력

set.intersection(set2) //두 집합의 교집합을 찾아줌

