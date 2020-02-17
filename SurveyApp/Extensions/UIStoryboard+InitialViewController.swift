//
//  UIStoryboard+InitialViewController.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/15/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.self) ")
        }
        return viewController
    }
}
