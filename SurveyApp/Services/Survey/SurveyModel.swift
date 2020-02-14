//
//  SurveyModel.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation

open class Survey: Codable {
    let id: String
    let title: String
    let description: String
    let coverImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case coverImageUrl = "cover_image_url"
    }
    
    public init() {
        id = ""
        title = ""
        description = ""
        coverImageUrl = ""
    }
}
