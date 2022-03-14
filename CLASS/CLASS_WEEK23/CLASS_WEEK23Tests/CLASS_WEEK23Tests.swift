//
//  CLASS_WEEK23Tests.swift
//  CLASS_WEEK23Tests
//
//  Created by 김진영 on 2022/02/28.
//

import XCTest
@testable import CLASS_WEEK23

class CLASS_WEEK23Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let array = [3, 6, 2, 8]
        let sortArray = array.sorted()
        
        XCTAssertEqual(sortArray, [2, 3, 6, 8])
        
        //viewcontroller의 firstTextField에 5자리 이상이 입력되었는지 확인하는 방법은?
        //1. viewcontroller를 어떻게 불러올 것인가?
        //-> 접근제어자를 public으로 설정한다
        //-> 하지만 @testable import를 해두었기 때문에, 테스트 할때만 접근하도록 허용된 상태임!
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.loadViewIfNeeded()
        vc.firstTextField.text = "안녕하신가"
        let result = vc.calculateTextFieldTextCount()
        
        XCTAssertEqual(result, 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
