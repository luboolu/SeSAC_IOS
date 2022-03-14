//
//  UserTextFieldTest.swift
//  CLASS_WEEK23UITests
//
//  Created by 김진영 on 2022/02/28.
//

import XCTest

class UserTextFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //유의사항: 최대한 메서드 이름을 길고 자세하게 작성할것
    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.launch()
        app.textFields["firstTextField"].tap()
        app.textFields["firstTextField"].typeText("안녕하세요")
        
        app.textFields["secondTextField"].tap()
        app.textFields["secondTextField"].typeText("1234")
        
        app.textFields["thirdTextField"].tap()
        app.textFields["thirdTextField"].typeText("1234")
                
        app.buttons["firstButton"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "firstLabel").label, "안녕하세요", "잘못됐다. 수정해야한다.")
    }

}
