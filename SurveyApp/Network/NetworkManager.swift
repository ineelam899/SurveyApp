//
//  NetworkManager.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func requestObject(_ router: APIRouterConfiguration, completion: @escaping ((Data?, String?) -> Void))
}

class NetworkManager: NetworkManagerProtocol {
    func requestObject(_ router: APIRouterConfiguration, completion: @escaping ((Data?, String?) -> Void)) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        do {
            guard let request = try router.asURLRequest() else {
                completion(nil, "Invalid URL generated.")
                return
            }
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(nil, error?.localizedDescription)
                    return
                }
                completion(data, nil)
            }.resume()
        }catch {
            completion(nil, error.localizedDescription)
        }
    }
}
