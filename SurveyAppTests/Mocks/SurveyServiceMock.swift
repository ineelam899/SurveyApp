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
    //MARK:- Data Members
    let mockObj: [Survey]
    
    //MARK:- Initializers
    init(mock: [Survey]) {
        mockObj = mock
    }
    
    //MARK:- Get Survey List
    func getSurveysList(page: Int, completion: @escaping (Result<[Survey], NetworkError>) -> Void) {
        completion(.success(mockObj))
    }
}

class SurveyServiceMockError: SurveyServiceProtocol {
    //MARK:- Initializers
    init() {}
    
    //MARK:- Get Survey List
    func getSurveysList(page: Int, completion: @escaping (Result<[Survey], NetworkError>) -> Void) {
        completion(.failure(.generic(NSError(domain: "Mock error", code: 401, userInfo: nil))))
    }
}
