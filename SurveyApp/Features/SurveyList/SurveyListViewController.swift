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
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- Data Members
    private let surveyCellIdentifier = "SurveyListCell"
    
    //MARK:- Injected Properties
    var viewModel: SurveyListViewModel!
    var coordinator: SurveyListCoordinator!
    
    //MARK:- Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
        activityIndicatorView.center = self.view.center
        fetchData()
    }
    
    //MARK:- Internals
    private func fetchData() {
        activityIndicatorView.startAnimating()
        viewModel.surveyListUpdatedBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.pageControl.numberOfPages = self?.viewModel.numberOfRows ?? 0
                self?.pageControl.addBorder(borderColor: .white, borderWidth: 1)
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
        viewModel.currentPage = 1
        fetchData()
    }
    
    @IBAction func didPressTakeTheSurvey(_ sender: Any) {
        coordinator.takeSurvey()
    }
}

extension SurveyListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height
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
        pageControl.currentPage = Int(row)
        
        let lastElement = viewModel.numberOfRows - 1
        if !viewModel.isLastPage && !activityIndicatorView.isAnimating && Int(row) == lastElement {
            viewModel.currentPage += 1
            fetchData()
        }
    }
}
