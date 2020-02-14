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

    let mockObj: [SurveyMock]
    init(mock: [SurveyMock]) {
        mockObj = mock
    }
    
    func getSurveysList(completion: @escaping (Result<[Survey], NetworkError>) -> Void) {
        completion(.success(mockObj))
    }
}

class SurveyServiceMockError: SurveyServiceProtocol {
    
    init() {}
    func getSurveysList(completion: @escaping (Result<[Survey], NetworkError>) -> Void) {
        completion(.failure(.generic(NSError(domain: "Mock error", code: 401, userInfo: nil))))
    }
}
