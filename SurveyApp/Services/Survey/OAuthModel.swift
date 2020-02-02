//
//  SurveyModel.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

struct OAuth: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }
}
