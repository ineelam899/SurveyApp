//
//  Constants.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://nimble-survey-api.herokuapp.com"
    }
    
    struct APIParameterKey {
        static let username = "username"
        static let password = "password"
        static let grantType = "grant_type"
    }
}

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
