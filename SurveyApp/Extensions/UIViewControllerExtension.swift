//
//  UIViewControllerExtension.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/15/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
