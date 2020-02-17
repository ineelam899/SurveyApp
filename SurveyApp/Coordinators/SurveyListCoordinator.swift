//
//  SurveyListCoordinator.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 2/17/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit

class SurveyListCoordinator {
    //MARK:- Data Members
    private let storyboardName = "Main"
    private var storyboard: UIStoryboard!
    private var presenter: UINavigationController!
    
    //MARK:- Initilizers
    init(presenter: UINavigationController){
        self.presenter = presenter
        self.storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    //MARK:- Navigation Methods
    func takeSurvey() {
        let takeSurveyViewController = storyboard.instantiateViewController(withIdentifier: "TakeSurveyViewController") as! TakeSurveyViewController
        presenter.pushViewController(takeSurveyViewController, animated: true)
    }
}
