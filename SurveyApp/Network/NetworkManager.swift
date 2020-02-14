//
//  NetworkManager.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func requestObject(_ router: APIRouterConfiguration, completion: @escaping ((Data?, NetworkError?) -> Void))
}

class NetworkManager: NetworkManagerProtocol {
    func requestObject(_ router: APIRouterConfiguration, completion: @escaping ((Data?, NetworkError?) -> Void)) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        do {
            guard let request = try router.asURLRequest() else {
                completion(nil, .badURL)
                return
            }
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(nil, .generic(error))
                    return
                }
                completion(data, nil)
            }.resume()
        }catch {
            completion(nil, .generic(error))
        }
    }
}
