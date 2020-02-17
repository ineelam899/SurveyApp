//
//  NetworkManagerTests.swift
//  SurveyAppTests
//
//  Created by sysnet on 2/17/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//
import XCTest
@testable import SurveyApp

class NetworkManagerTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestObject() {
        //GIVEN
        let expectation = XCTestExpectation(description: "event wait")
        let networkManager = NetworkManager()
        let username = "carlos@nimbl3.com"
        let password = "antikera"
        let grantType = "password"
        let router: APIRouter = .oAuth(username: username, password: password, grantType: grantType)
        
        //WHEN
        networkManager.requestObject(router) { (data: Data?, error: Error?) in
            guard let data = data else {
                print(error ?? "Error occured.")
                return
            }
            
            XCTAssertNotNil(data, "Data is nil")
            //THEN
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}