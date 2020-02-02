//
//  APIResult.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case error(String)
}
