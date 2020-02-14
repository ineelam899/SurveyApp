//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol SurveyServiceProtocol {
    func getSurveysList(completion: @escaping (Result<SurveyResponse, NetworkError>)-> Void)
    func getOAuthToken(completion: @escaping (Result<OAuth, NetworkError>)-> Void)
}

class SurveyService: SurveyServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getSurveysList(completion: @escaping (Result<SurveyResponse, NetworkError>)-> Void) {
        let router: APIRouter = .surveyList
        networkManager.requestObject(router) { (data: Data?, error: Error?) in
            guard let data = data, let surveys = try? JSONDecoder().decode([Survey].self, from: data) else {
                completion(.failure(.badJSON))
                return
            }
            completion(.success(SurveyResponse.init(surveys: surveys)))
        }
    }
    
    func getOAuthToken(completion: @escaping (Result<OAuth, NetworkError>)-> Void) {
        let router: APIRouter = .oAuth(username: "carlos@nimbl3.com", password: "antikera", grantType:"password")
        networkManager.requestObject(router) { (data: Data?, error: Error?) in
             guard let data = data, let oauth = try? JSONDecoder().decode(OAuth.self, from: data) else {
                completion(.failure(.badJSON))
                return
            }
            completion(.success(oauth))
        }
    }
}
