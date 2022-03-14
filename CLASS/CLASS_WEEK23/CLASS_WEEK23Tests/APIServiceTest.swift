//
//  APIServiceTest.swift
//  CLASS_WEEK23Tests
//
//  Created by 김진영 on 2022/03/03.
//

import XCTest
@testable import CLASS_WEEK23

class APIServiceTest: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = APIService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    //CallRequest > number 1~45
    func testExample() throws {
        sut.number = 100 //초기값 0으로 되어 있으므로
        
        sut.callRequest { number in
            print(number)
            XCTAssertLessThanOrEqual(self.sut.number, 45)
            XCTAssertGreaterThanOrEqual(self.sut.number, 1)
        }
    }
    
    //비동기를 실행하기 위해선 어떻게 해야하는가?
    //expection, fulfill, wait
    //네트워크: 아이폰 네트워크 응답 X, API 서버 점검, API 지연
    //-> 테스트 더블: 테스트 코드와 상호작용을 할 수 있는 가짜 객체 생성(ex. 스턴트맨)
    //-> Dummy, Stub, Fake, Spy, Mock -> 테스트가 가능한 객체를 만듦
    func testExample2() throws {
        
        let promise = expectation(description: "Waiting Lotto Number, Completion Handler Invoked")
        
        sut.number = 100 //초기값 0으로 되어 있으므로
        
        sut.callRequest { number in
            print(number)
            XCTAssertLessThanOrEqual(self.sut.number, 45)
            XCTAssertGreaterThanOrEqual(self.sut.number, 1)
            promise.fulfill() //expectation으로 정의한 테스트 조건을 충족한 시점에 호출.
        }
        
        wait(for: [promise], timeout: 5) //timeout: 5초동안 기다림, 5초가 지나면 실패로 간주함
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
