//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol SurveyServiceProtocol {
    func getSurveysList(page: Int, completion: @escaping (Result<[Survey], NetworkError>)-> Void)
}

class SurveyService: SurveyServiceProtocol {
    //MARK:- Data Members
    private let networkManager: NetworkManagerProtocol
    
    //MARK:- Initializers
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    //MARK:- Get Survey List
    func getSurveysList(page: Int, completion: @escaping (Result<[Survey], NetworkError>)-> Void) {
        let router: APIRouter = .surveyList(page: page)
        networkManager.requestObject(router) { (result) in
            switch result {
            case .success(let data):
                guard let surveys = try? JSONDecoder().decode([Survey].self, from: data) else {
                    completion(.failure(.badJSON))
                    return
                }
                completion(.success(surveys))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
