//
//  SurveyListViewModel.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class SurveyListViewModel {
    //MARK:- Data Members
    private let surveyService: SurveyServiceProtocol
    private var surveys: [Survey]
    private lazy var oAuthService: OAuthService = OAuthService(networkManager: NetworkManager())
    private var page: Int = 1
    
    var isLastPage: Bool = false
    var currentPage: Int {
        set {
            page = newValue
            if(page == 1){
                surveys.removeAll()
            }
        }
        get { page }
    }
    
    //MARK:- Reload Tableview Hook
    var surveyListUpdatedBlock: (()->Void)? = nil
    
    //MARK:- Error Hook
    var errorBlock: ((NetworkError)->Void)? = nil
    
    //MARK:- Initializers
    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
        surveys = []
    }
    
    //MARK:- Loads Survey List
    func load() {
        let authentication = KeychainWrapper.standard.string(forKey: HTTPHeaderField.authentication.rawValue)
        if(authentication == nil){
            getOAuthToken()
        }else {
            getSurveysList()
        }
    }
    
    //MARK:- Internals
    private func getSurveysList(){
        surveyService.getSurveysList(page: currentPage) { [weak self] (result) in
            switch result {
            case .success(let surveys):
                self?.isLastPage = (surveys.count == 0) ? true : false
                self?.surveys.append(contentsOf: surveys)
                self?.surveyListUpdatedBlock?()
            case .failure(let error):
                self?.errorBlock?(error)
            }
        }
    }
    
    private func getOAuthToken(){
        oAuthService.getOAuthToken() { [weak self] (result) in
            switch result {
            case .success(let oauthAPIModel):
                let authentication = "\(oauthAPIModel.tokenType) \(oauthAPIModel.accessToken)"
                KeychainWrapper.standard.set(authentication, forKey: HTTPHeaderField.authentication.rawValue)
                self?.getSurveysList()
            case .failure(let error):
                self?.errorBlock?(error)
            }
        }
    }
    
    //MARK:- UITableview Data Related
    var numberOfRows: Int {
        return surveys.count
    }
    
    func cellModelForRow(index: Int) -> SurveyListCell.Model {
        let survey = surveys[index]
        return SurveyListCell.Model(name: survey.title, description: survey.description, imageURL: URL(string: survey.coverImageUrl+"l"))
    }
}
