//환율 변동 프로그램 21.10.13 과제
import UIKit

struct ExchangeRate {
    
    var currencyRate: Double {
        //현재 환율
        willSet {
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet {
            print("currencyRate willSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {
        //미국 달러
        willSet {
            print("USD willSet - 환전 금액: USD:\(newValue)달러로 환전될 예정")
        }
        didSet {
            print("USD didSet - KRW: \(KRW)원 -> \(USD)달러로 환전되었음")
        }
    }

    var KRW: Double {
        //한국 원
        didSet {
            USD = KRW / currencyRate
        }
    }

}

var rate = ExchangeRate(currencyRate: 1100, USD: 1, KRW: 500000)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
