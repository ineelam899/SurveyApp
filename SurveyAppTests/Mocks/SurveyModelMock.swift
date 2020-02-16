//
//  SurveyModelMock.swift
//  SurveyAppTests
//
//  Created by Neelam Shehzadi on 2/2/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit
@testable import SurveyApp

class SurveyMock: Survey {
    //MARK:- Initializers
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
