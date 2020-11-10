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
    @IBOutlet weak var footerView: FooterView!
    
    // MARK: - Public Properties
    //
    var entriesInteractor: EntriesInteractor!
    var entriesPresenter: EntriesPresenter!
    var selectedEntry: Entry?
    
    // MARK: - Private Properties
    //
    private var isRequestingEntries: Bool = true
    
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
        
        requestEntries(fromNextSlice: false, withTableViewHiding: true)
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
    private func requestEntries(fromNextSlice nextSlice: Bool, withTableViewHiding hideTableView: Bool) {
        
        isRequestingEntries = true
        
        if hideTableView {
            activityIndicatorView.show()
            entriesTableView.isHidden = true
        }
        
        entriesInteractor.requestEntries(fromNextSlice: nextSlice)
    }
}


// MARK: - UIRefreshControl setup/configuration

extension EntriesViewController {
    
    private func setupRefreshControl() {
       refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        requestEntries(fromNextSlice: false, withTableViewHiding: false)
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
        footerView.showActivityIndicator(false)
        entriesTableView.reloadData()
        
        activityIndicatorView.hide()
        entriesTableView.isHidden = false
        
        isRequestingEntries = false
    }
}


// MARK: - Pagination 

extension EntriesViewController {
    
    @IBAction func requestNextEntries() {
        
        footerView.showActivityIndicator(true)
        
        requestEntries(fromNextSlice: true, withTableViewHiding: false)
    }
}
