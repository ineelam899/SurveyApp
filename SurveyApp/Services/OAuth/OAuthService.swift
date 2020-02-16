//
//  OAuthService.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/15/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol OAuthServiceProtocol {
    func getOAuthToken(completion: @escaping (Result<OAuth, NetworkError>)-> Void)
}

class OAuthService: OAuthServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    //MARK:- Initializers
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    //MARK:- Get OAuthToken
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

