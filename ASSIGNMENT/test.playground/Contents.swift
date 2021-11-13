import UIKit
import Darwin
import DataDetection


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




//let now = Date()
//let dateFomatter = DateFormatter()
//
//dateFomatter.dateFormat = "yyyyMMdd"
//
//let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
//
//let searchDate = dateFomatter.string(from: yesterday)
//
//type(of: searchDate)
//

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: startDay)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
            guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
           return gregorian.date(byAdding: .day, value: 7, to: startDay)
       }
}

func convertDateToLocalTime(_ date: Date) -> Date {
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
    print(timeZoneOffset)
    return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
}

let now = convertDateToLocalTime(Date())

let startWeek = convertDateToLocalTime(now.startOfWeek!)
let endWeek = convertDateToLocalTime(now.endOfWeek!)


let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "ko_KR")
dateFormatter.timeZone = TimeZone(abbreviation: "KST")
dateFormatter.dateFormat = "yyyy MM dd HH:mm"

let nowKR = dateFormatter.string(from: Date())
print(nowKR)

print("Local time is: \(now)")

print("Start of week is: \(startWeek)")

print("End of week is: \(endWeek)")

let weekDateFormatter = DateFormatter()
weekDateFormatter.locale = Locale(identifier: "ko_KR")
weekDateFormatter.timeZone = TimeZone(abbreviation: "KST")
weekDateFormatter.dateFormat = "EEEE"
print(weekDateFormatter.string(from: now))

let todayDateFormatter = DateFormatter()
todayDateFormatter.locale = Locale(identifier: "ko_KR")
todayDateFormatter.timeZone = TimeZone(abbreviation: "KST")
todayDateFormatter.dateFormat = "a hh:mm"
print(todayDateFormatter.string(from: Date()))


let calendar = Calendar.current
let today = Date()
let localDate = Date(timeInterval: TimeInterval(calendar.timeZone.secondsFromGMT()), since: today)

if calendar.compare(today, to: localDate, toGranularity: .day) == .orderedSame {
    print("This is True")
} else {
    print("This is False")
}
