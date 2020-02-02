//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol SurveyServiceProtocol {
    func getSurveysList(completion: @escaping (APIResult<SurveyResponse>)-> Void)
    func getOAuthToken(completion: @escaping (APIResult<OAuth>)-> Void)
}

class SurveyService: SurveyServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getSurveysList(completion: @escaping (APIResult<SurveyResponse>)-> Void) {
        let router: APIRouter = .surveyList
        networkManager.requestObject(router) { (data: Data?, error: String?) in
            guard let data = data, let surveys = try? JSONDecoder().decode([Survey].self, from: data) else {
                completion(APIResult.error(error ?? "JSON parsing issue occurred."))
                return
            }
            completion(APIResult.success(SurveyResponse.init(surveys: surveys)))
        }
    }
    
    func getOAuthToken(completion: @escaping (APIResult<OAuth>)-> Void) {
        let router: APIRouter = .oAuth(username: "carlos@nimbl3.com", password: "antikera", grantType:"password")
        networkManager.requestObject(router) { (data: Data?, error: String?) in
             guard let data = data, let oauth = try? JSONDecoder().decode(OAuth.self, from: data) else {
                completion(APIResult.error(error ?? "JSON parsing issue occurred."))
                return
            }
            completion(APIResult.success(oauth))
        }
    }
}
