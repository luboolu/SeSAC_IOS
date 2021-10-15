import UIKit

var list: [String] = UserDefaults.standard.object(forKey: "shopping") as! [String]
{
    didSet {
        print("\(oldValue) -> \(list)")
    }
}

var myList: [String] = []


myList.append("c")

