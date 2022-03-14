import UIKit

var greeting = "Hello, playground"

let chatDate = "2022-02-25T07:22:49.026Z"


let isoFormat = ISO8601DateFormatter()
isoFormat.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

let charParseFormat = DateFormatter()
charParseFormat.dateFormat = "HH:mm"
charParseFormat.timeZone = TimeZone(identifier: TimeZone.current.identifier)

let date = isoFormat.date(from: chatDate)

print(isoFormat.string(from: Date.now))
print(isoFormat.date(from: chatDate))

let date_1 = isoFormat.date(from: chatDate)!
let date_2 = charParseFormat.string(from: date_1)
