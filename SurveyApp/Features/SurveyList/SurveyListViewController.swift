//
//  SurveyListViewController.swift
//  SurveyApp
//
//  Created by Neelam Shehzadi on 1/29/20.
//  Copyright © 2020 Neelam Shehzadi. All rights reserved.
//

import UIKit
import THEPageControl
import NVActivityIndicatorView

class SurveyListViewController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: PageControl!
    
    //MARK:- Data Members
    private let surveyCellIdentifier = "SurveyListCell"
    
    //MARK:- Injected Properties
    var viewModel: SurveyListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.configuration.layoutAxis = .vertical
        pageControl.configuration.spacing = 8
        fetchData()
    }
    
    private func fetchData() {
        startAnimating()
        viewModel.surveyListUpdatedBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.stopAnimating()
                self?.pageControl.dots = Array(repeating: .customStyle, count: self?.viewModel.numberOfRows ?? 0)
                self?.tableView.reloadData()
            }
        }
        viewModel.errorBlock = { [weak self] message in
            DispatchQueue.main.async {
                self?.stopAnimating()
                self?.showErrorAlert(message: message)
            }
        }
        viewModel.load()
    }
    
    //MARK:- IBActions
    
    @IBAction func didPressRefresh(_ sender: Any) {
        fetchData()
    }
}

extension SurveyListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension SurveyListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let row = round(scrollView.contentOffset.y/tableView.frame.size.height)
        pageControl.setActiveDotIndex(Float(row), animated: false)
    }
}
