//
//  SurveyListCell.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit
import Nuke

class SurveyListCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var surveyImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK:- Initialize Cell UI
    func initGUI(model: Model) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        if let url = model.imageURL {
            Nuke.loadImage(with: url, into: surveyImageView)
        } else {
            surveyImageView.image = UIImage(named: "placeholder")
        }
    }
}

extension SurveyListCell {
    struct Model {
        let name: String
        let description: String
        let imageURL: URL?
    }
}

