//
//  EntriesInteractor.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit

class EntriesInteractor: NSObject {

    // MARK: - Constants
    //
    private let topEntriesUrl = "https://www.reddit.com/top.json"
    
    // MARK: - Public Properties
    //
    weak var presenter: EntriesPresenter!
    var entriesCollection: EntriesCollection?
    
    // MARK: - Private Properties
    //
    var networkWorker: NetworkWorker?
    
    // MARK: - Public Methods
    //
    func requestEntries() {
        
        if networkWorker == nil {
            networkWorker = NetworkWorker(withInteractor: self)
        }
        
        networkWorker?.performGetRequest(withURLString: topEntriesUrl, completion: { [weak self] entries in
            
            self?.entriesCollection = EntriesCollection(withEntries: entries)
            
            self?.presenter.present()
        })
    }
}
