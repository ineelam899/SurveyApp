//
//  URLComponents+SetQueryItems.swift
//  SurveyApp
//
//  Created by sysnet on 2/15/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}
