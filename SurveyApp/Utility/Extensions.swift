//
//  Extensions.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit
import THEPageControl

extension UIViewController {
    func showErrorAlert(error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.self) ")
        }
        return viewController
    }
}

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


