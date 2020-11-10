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
    var selectedEntry: Entry?
    
    // MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entriesTableView.dataSource = self
        entriesTableView.delegate = self
        
        entriesInteractor = EntriesInteractor()
        entriesPresenter = EntriesPresenter(withViewController: self, interactor: entriesInteractor)
        entriesInteractor.presenter = entriesPresenter
        
        setupRefreshControl()
        
        requestEntries(withTableViewHiding: true)
    }
    
    // MARK: - Navigation
    //
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        guard let detailViewController: DetailViewController = segue.destination as? DetailViewController else {
            
            return
        }
        
        // Pass the selected object to the new view controller.
        detailViewController.entry = selectedEntry
    }
    
    // MARK: - Private Methods
    //
    private func requestEntries(withTableViewHiding hideTableView: Bool) {
        
        if hideTableView {
            activityIndicatorView.show()
            entriesTableView.isHidden = true
        }
        
        entriesInteractor.requestEntries()
    }
}


// MARK: - UIRefreshControl setup/configuration

extension EntriesViewController {
    
    private func setupRefreshControl() {
       refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        requestEntries(withTableViewHiding: false)
    }
    
    private var refreshControl: UIRefreshControl {
        guard let refreshControl = entriesTableView.refreshControl else {
            entriesTableView.refreshControl = UIRefreshControl()
            return entriesTableView.refreshControl!
        }
        return refreshControl
    }
}


// MARK: - Display

extension EntriesViewController: EntriesViewReloadable {
    
    func reload() {
        
        refreshControl.endRefreshing()
        entriesTableView.reloadData()
        
        activityIndicatorView.hide()
        entriesTableView.isHidden = false
    }
}
