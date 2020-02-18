//
//  UIPageControl+CustomPageControl.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/18/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit

extension UIPageControl {
    func addBorder(borderColor: UIColor, borderWidth: CGFloat) {
        for (_, dotView) in self.subviews.enumerated() {
            dotView.layer.cornerRadius = dotView.frame.size.height / 2
            dotView.layer.borderColor = borderColor.cgColor
            dotView.layer.borderWidth = borderWidth
        }
    }
}
