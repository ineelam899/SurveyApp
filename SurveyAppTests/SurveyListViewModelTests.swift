//
//  SurveyListViewModelTests.swift
//  SurveyAppTests
//
//  Created by Neelam Shehzadi on 2/2/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import XCTest
@testable import SurveyApp

class SurveyListViewModelTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSurveyLoading() {
        //GIVEN
        let expectation = XCTestExpectation(description: "event wait")
        let viewModel = SurveyListViewModel(surveyService: SurveyServiceMock(mock: [Survey()]))
        
        viewModel.surveyListUpdatedBlock = {
            //THEN
            expectation.fulfill()
        }
        //WHEN
        viewModel.load()
        wait(for: [expectation], timeout: 20)
    }
    
    func testSurveyLoadingError() {
        //GIVEN
        let expectation = XCTestExpectation(description: "event wait")
        let viewModel = SurveyListViewModel(surveyService: SurveyServiceMockError())
        viewModel.errorBlock = { _ in
            //THEN
            expectation.fulfill()
        }
        //WHEN
        viewModel.load()
        wait(for: [expectation], timeout: 1)
    }
    
    func testNumberOfRows() {
        let viewModel = SurveyListViewModel(surveyService: SurveyServiceMock(mock: [Survey()]))
        XCTAssert(viewModel.numberOfRows == 0)
    }
}
