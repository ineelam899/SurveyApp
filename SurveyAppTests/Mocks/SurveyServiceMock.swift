//
//  SurveyServiceMock.swift
//  SurveyAppTests
//
//  Created by Neelam Shehzadi on 2/2/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit
@testable import SurveyApp

class SurveyServiceMock: SurveyServiceProtocol {

    let mockObj: SurveyResponseMock
    init(mock: SurveyResponseMock) {
        mockObj = mock
    }
    
    func getSurveysList(completion: @escaping (APIResult<SurveyResponse>) -> Void) {
        completion(APIResult.success(mockObj))
    }
    
    func getOAuthToken(completion: @escaping (APIResult<OAuth>) -> Void) {}
}

class SurveyServiceMockError: SurveyServiceProtocol {
    
    init() {}
    func getSurveysList(completion: @escaping (APIResult<SurveyResponse>) -> Void) {
        completion(APIResult.error("Mock error"))
    }
    
    func getOAuthToken(completion: @escaping (APIResult<OAuth>) -> Void) {}
}
