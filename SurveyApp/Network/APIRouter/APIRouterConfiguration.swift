//
//  APIRouterConfiguration.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol APIRouterConfiguration {
    var baseURL: String { get }
    var apiURL: URL? { get }
    var method: String { get }
    var parameters: [String: Any]? { get }
    var isOAuthCall: Bool {get}
}

extension APIRouterConfiguration {
    var baseURL: String {
        return K.ProductionServer.baseURL
    }
}

extension APIRouterConfiguration {
    public func asURLRequest() throws -> URLRequest? {
        guard let apiURL = apiURL else { return nil }
        var urlRequest = URLRequest(url: apiURL)
        urlRequest.httpMethod = method
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if(!isOAuthCall && KeychainWrapper.standard.string(forKey: HTTPHeaderField.authentication.rawValue) != nil){
            urlRequest.setValue(KeychainWrapper.standard.string(forKey: HTTPHeaderField.authentication.rawValue), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        if(method == HTTPMethod.post.rawValue){
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters ?? [], options: .prettyPrinted)
        }
        return urlRequest
    }
}

