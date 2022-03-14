//
//  InAppViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/07.
//

import Foundation
import UIKit
import StoreKit
import SnapKit

class InAppViewController: UIViewController {
    
    //앱 내 구입 상품의 제품 ID
    //1. 인앱 상품 ID 정의
    var productIdentifier: Set<String> = ["com.jy.CLASS_WEEK15_cookie_10", "com.jy.CLASS_WEEK15_cookie_100"]
    
    //3-1. 인앱 상품 배열
    var productArray = Array<SKProduct>()
    var product: SKProduct? //사용자가 선택한 상품
    
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestProductData()
        
        
        view.addSubview(button)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
    }
    
    //4. 구매 버튼 클릭
    @objc func buttonClicked() {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
    }
    
    //2. ProductIdentifier에 정의된 상품 ID에 대한 정보 가져오기 및 사용자의 디바이스가 인앱결제가 가능한지 여부 확인
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            let request = SKProductsRequest(productIdentifiers: productIdentifier)
            
            request.delegate = self
            request.start() //인앱 상품 조회 시자
        } else {
            print("In App Purchase Not Enabled")
        }
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        //SnadBox : "https://sandbox.itunes.apple.com/verifyReceipt"
        //Itunes Store: "https://buy.itunes.apple.com/verifyReceipt"
        
        let receipFileURL = Bundle.main.appStoreReceiptURL
        let receipData = try? Data(contentsOf: receipFileURL!)
        let receipString = receipData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
         
        print(receipString)
        //거래 내역(transaction)을 큐에서 제거
        //SKPaymentQueue.finishTransaction(transaction)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
}

extension InAppViewController: SKProductsRequestDelegate {
    
    //3. 인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var products = response.products
        
        if products.count > 0 {
            //상품을 하나씩 조회
            for i in products {
                productArray.append(i)
                product = i //옵션
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription)
            }
        } else {
            print("No Product Found")
        }
        
    }
}

//SKPaymentTransactionObserver: 구매 취소, 승인 등에 대한 프로토콜
extension InAppViewController: SKPaymentTransactionObserver {
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                
            case .purchased: //구매 승인 이후에 영수증 검증
                print("Transaction Approved. \(transaction.payment.productIdentifier)")
            case .failed: //실패 토스트, transaction
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            @unknown default:
                break

            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removed transaction")
    }
    
    
    
    
}
