//
//  Date+Extension.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/09.
//

import Foundation

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: startDay)
    }
}



//func convertDateToLocalTime(_ date: Date) -> Date {
//    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
//
//    return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
//}

extension DateFormatter {
    //현재 시간과 비교하여 각기 다른 format으로 return해주어야함!!
    //1. 오늘 -> 오전/오후 HH:mm
    //2. 이번주 -> 월요일, 화요일 ,,,,
    //3. else -> yyyy.MM.dd HH.mm
    static var customFormat: DateFormatter {

        let date = DateFormatter()
        date.dateFormat = "yyyy.MM.dd HH:mm"
        

        return date
    }
    
    static var todayFormat: DateFormatter {
        //오늘 작성된 메모라면
        let todayFormatter = DateFormatter()
        
        todayFormatter.locale = Locale(identifier: "ko_KR")
        todayFormatter.timeZone = TimeZone(abbreviation: "KST")
        todayFormatter.dateFormat = "a hh:mm"
        
        return todayFormatter
    }
    
    static var thisWeekFormat: DateFormatter {
        //이번주에 작성된 메모라면
        let thisWeekFormatter = DateFormatter()
        
        thisWeekFormatter.locale = Locale(identifier: "ko_KR")
        thisWeekFormatter.timeZone = TimeZone(abbreviation: "KST")
        thisWeekFormatter.dateFormat = "EEEE"
        
        return thisWeekFormatter
    }
    
    static var defaultFormat: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyy.MM.dd HH:mm"
        
        return date
    }
}
