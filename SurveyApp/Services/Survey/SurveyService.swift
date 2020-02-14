//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol SurveyServiceProtocol {
    func getSurveysList(completion: @escaping (Result<[Survey], NetworkError>)-> Void)
}

class SurveyService: SurveyServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getSurveysList(completion: @escaping (Result<[Survey], NetworkError>)-> Void) {
        let router: APIRouter = .surveyList
        networkManager.requestObject(router) { (data: Data?, error: Error?) in
            guard let data = data, let surveys = try? JSONDecoder().decode([Survey].self, from: data) else {
                completion(.failure(.badJSON))
                return
            }
            completion(.success(surveys))
        }
    }
}
