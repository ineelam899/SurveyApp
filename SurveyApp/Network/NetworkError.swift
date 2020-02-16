//
//  NetworkError.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/14/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

enum NetworkError: Error {
    case badURL
    case badJSON
    case generic(Error?)
    
    var description: String {
        switch self {
        case .badURL:
            return "Invalid URL generated."
        case .badJSON:
            return "JSON parsing issue occurred."
        case .generic(let error):
            return error?.localizedDescription ?? "Unknown error occured."
        }
    }
}
