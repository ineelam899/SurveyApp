//
//  NetworkManager.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func requestObject(_ router: APIRouterConfiguration, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func requestObject(_ router: APIRouterConfiguration, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        do {
            guard let request = try router.asURLRequest() else {
                completion(.failure(.badURL))
                return
            }
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(.failure(.generic(error)))
                    return
                }
                completion(.success(data))
            }.resume()
        }catch {
            completion(.failure(.generic(error)))
        }
    }
}
