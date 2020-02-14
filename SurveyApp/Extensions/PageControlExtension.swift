//
//  PageControlExtension.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/15/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import THEPageControl

extension PageControl.Dot {
    static var customStyle: PageControl.Dot {
        let regularStyle = PageControl.Dot.Style(
            radius: 5,
            fillColor: .clear,
            strokeColor: .white,
            strokeWidth: 1
        )
        
        let activeStyle = PageControl.Dot.Style(
            radius: 5,
            fillColor: .white,
            strokeColor: .white,
            strokeWidth: 1
        )
        
        return PageControl.Dot(
            regularStyle: regularStyle,
            activeStyle: activeStyle
        )
    }
}
