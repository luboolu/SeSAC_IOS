//
//  ValidatorTests.swift
//  CLASS_WEEK23Tests
//
//  Created by 김진영 on 2022/03/02.
//

import XCTest
@testable import CLASS_WEEK23

class ValidatorTests: XCTestCase {
    
    var sut: Validator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError() //문서 상에 쓰라고 명시되어 있음
        sut = Validator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError() //초기화 후 super class 호출(명확하지는 않음)
    }

    func testValidator_validID_ReturnTrue() throws {
        //Given
        let user = User(email: "jack@jack.com", password: "123456", check: "123456")
        //When
        let valid = sut.isValidID(id: user.email)
        //Then
        XCTAssertTrue(valid, "@없거나 6글자 미만임")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
