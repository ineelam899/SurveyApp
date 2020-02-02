//
//  APIRouter.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

enum APIRouter: APIRouterConfiguration {
    case oAuth(username: String, password: String, grantType: String)
    case surveyList

    var method: String {
        switch self {
        case .oAuth:
            return HTTPMethod.post.rawValue
        case .surveyList:
            return HTTPMethod.get.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .oAuth:
            return "/oauth/token"
        case .surveyList:
            return "/surveys.json"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .oAuth(let username, let password, let grantType):
            return [K.APIParameterKey.username: username,               K.APIParameterKey.password: password,
                K.APIParameterKey.grantType: grantType]
        case .surveyList:
            return nil
        }
    }
    
    var isOAuthCall: Bool {
        switch self {
        case .oAuth:
            return true
        default:
            return false
        }
    }
    
    var apiURL: URL? {
        var urlComp = URLComponents(string: baseURL)
        urlComp?.path = path
        guard let url = urlComp?.url else {return nil}
        return url
    }
}
