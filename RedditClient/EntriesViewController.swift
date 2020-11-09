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
        
        requestEntries()
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
