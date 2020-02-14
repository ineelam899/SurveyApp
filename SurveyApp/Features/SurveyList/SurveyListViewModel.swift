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

    private let surveyService: SurveyServiceProtocol
    private var surveys: [Survey]
    private lazy var oAuthService = OAuthService(networkManager: NetworkManager())
    
    /// Reload table view hook for ViewController
    var surveyListUpdatedBlock: (()->Void)? = nil
    
    /// Error hook for ViewController
    var errorBlock: ((NetworkError)->Void)? = nil
    
    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
        surveys = []
    }
    
    /// Loads surveys list
    func load() {
        let authentication = KeychainWrapper.standard.string(forKey: HTTPHeaderField.authentication.rawValue)
        if(authentication == nil){
            getOAuthToken()
        }else {
            getSurveysList()
        }
    }
    
    private func getSurveysList(){
        surveyService.getSurveysList() { [weak self] (result) in
            switch result {
            case .success(let surveyAPIModel):
                self?.surveys = surveyAPIModel.surveys
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
    
    //MARK:- UITableview data related methods
    var numberOfRows: Int {
        return surveys.count
    }
    
    func cellModelForRow(index: Int) -> SurveyListCell.Model {
        let survey = surveys[index]
        return SurveyListCell.Model(name: survey.title, description: survey.description, imageURL: URL(string: survey.coverImageUrl+"l"))
    }
}
