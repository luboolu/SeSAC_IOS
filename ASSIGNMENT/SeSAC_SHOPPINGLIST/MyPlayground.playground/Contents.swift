import UIKit

//UserDefaults 초기화
for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }



var shoppingList: [String] = ["첫번째 목록", "두번째 목록"]

UserDefaults.standard.set(shoppingList, forKey: "list")

//저장된 userDefault 값 가져오기
var shopList = UserDefaults.standard.array(forKey: "list") as? [String] ?? []
//print(shopList)
//새로 추가할 값
shopList.append("세번째 목록")
//추가된 데이터를 userdefault에 저장
UserDefaults.standard.set(shopList, forKey: "list")
var newShopList = UserDefaults.standard.array(forKey: "list") as? [String] ?? []
//print(newShopList)
