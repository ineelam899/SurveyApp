//
//  AppCoordinator.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit

class AppCoordinator {
    //MARK:- Data Members
    private let storyboardName = "Main"
    
    //MARK:- Configure Methods
    func configureRootController(window: UIWindow?) {
        let navController: UINavigationController = UIStoryboard(name: storyboardName, bundle: Bundle.main).initialViewController()
        if let surveyListingController = navController.viewControllers.first as? SurveyListViewController {
            let networkManager = NetworkManager()
            let surveyService = SurveyService(networkManager: networkManager)
            surveyListingController.viewModel = SurveyListViewModel(surveyService: surveyService)
        }
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
