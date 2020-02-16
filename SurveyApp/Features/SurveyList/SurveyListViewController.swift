//
//  SurveyListViewController.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit

class SurveyListViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //MARK:- Data Members
    private let surveyCellIdentifier = "SurveyListCell"
    
    //MARK:- Injected Properties
    var viewModel: SurveyListViewModel!
    
    //MARK:- Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        fetchData()
    }
    
    //MARK:- Internals
    private func fetchData() {
        activityIndicatorView.startAnimating()
        viewModel.surveyListUpdatedBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        viewModel.errorBlock = { [weak self] error in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
                self?.showErrorAlert(error: error)
            }
        }
        viewModel.load()
    }
    
    //MARK:- IBActions
    @IBAction func didPressRefresh(_ sender: Any) {
        fetchData()
    }
}

extension SurveyListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: surveyCellIdentifier, for: indexPath) as! SurveyListCell
        cell.initGUI(model: viewModel.cellModelForRow(index: indexPath.row))
        return cell
    }
}

extension SurveyListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let row = round(tableView.contentOffset.y/tableView.frame.size.height)
        let lastElement = viewModel.numberOfRows - 1
        if !viewModel.isLastPage && !activityIndicatorView.isAnimating && Int(row) == lastElement {
            viewModel.currentPage += 1
            fetchData()
        }
    }
}
