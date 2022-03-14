//
//  LoginViewControllerTests.swift
//  CLASS_WEEK23Tests
//
//  Created by 김진영 on 2022/03/02.
//

import XCTest
@testable import CLASS_WEEK23

class LoginViewControllerTests: XCTestCase {
    
    //system under test
    var sut: LoginViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

//    //BDD(Behavior Driven Development)
//    func testLoginViewController_validID_ReturnTrue() throws {
//        //Given
//        sut.idTextField.text = "jack@jack.com"
//        //When
//        let valid = sut.isValidID()
//        //Then
//        XCTAssertTrue(valid, "@이 없거나 6글자 미만이라서 안될 수 있음")
//    }
//
//    func testLoginViewController_invalidPassword_ReturnTrue() throws {
//        sut.passwordTextField.text = "1234"
//
//        let valid = sut.isValidPassword()
//
//        XCTAssertTrue(valid, "패스워드 로직 확인")
//    }
//
//    func testLoginViewController_idTextField_ReturnNil() throws {
//        sut.idTextField = nil
//
//        let value = sut.idTextField
//
//        XCTAssertNil(value)
//    }
//
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
