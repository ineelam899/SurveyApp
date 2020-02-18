//
//  SurveyServiceTests.swift
//  SurveyAppTests
//
//  Created by Neelam Shehzadi on 2/16/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import XCTest
@testable import SurveyApp

class SurveyServiceTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSurveyList() {
        //GIVEN
        let expectation = XCTestExpectation(description: "event wait")
        let surveyService = SurveyService(networkManager: NetworkManager())
        
        //WHEN
        surveyService.getSurveysList(page: 1) { (result) in
            switch result {
            case .success( _):
                //THEN
                expectation.fulfill()
            case .failure(let error):
                if(error.isOffline){
                    //THEN
                    expectation.fulfill()
                }
                print(error)
            }
        }
        wait(for: [expectation], timeout: 20)
    }
}
