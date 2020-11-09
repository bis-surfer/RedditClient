//
//  EntriesViewController.swift
//  RedditClient
//
//  Created by Ilya Borisov on 07.11.2020.
//

import UIKit

class EntriesViewController: UIViewController {

    // MARK: - Outlets
    //
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var entriesTableView: UITableView!
    
    // MARK: - Public Properties
    //
    var entriesInteractor: EntriesInteractor!
    var entriesPresenter: EntriesPresenter!
    
    // MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entriesTableView.dataSource = self
        
        entriesInteractor = EntriesInteractor()
        entriesPresenter = EntriesPresenter(withViewController: self, interactor: entriesInteractor)
        entriesInteractor.presenter = entriesPresenter
        
        requestEntries()
    }
    
    // MARK: - Private Methods
    //
    private func requestEntries() {
        activityIndicatorView.show()
        entriesTableView.isHidden = true
        
        entriesInteractor.requestEntries()
    }
}


// MARK: - Display

extension EntriesViewController: EntriesViewReloadable {
    
    func reload() {
        entriesTableView.reloadData()
        
        activityIndicatorView.hide()
        entriesTableView.isHidden = false
    }
}
