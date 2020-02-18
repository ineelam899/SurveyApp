//
//  OAuthServiceTests.swift
//  SurveyAppTests
//
//  Created by Neelam Shehzadi on 2/16/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import XCTest
import SwiftKeychainWrapper
@testable import SurveyApp

class OAuthServiceTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOAuthToken() {
        //GIVEN
        let expectation = XCTestExpectation(description: "event wait")
        let oAuthService = OAuthService(networkManager: NetworkManager())
        
        //WHEN
        oAuthService.getOAuthToken() { (result) in
            switch result {
            case .success(let oauthAPIModel):
                let authentication = "\(oauthAPIModel.tokenType) \(oauthAPIModel.accessToken)"
                KeychainWrapper.standard.set(authentication, forKey: HTTPHeaderField.authentication.rawValue)
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
        wait(for: [expectation], timeout: 5)
    }
}
