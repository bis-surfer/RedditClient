//
//  EntriesInteractor.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit

class EntriesInteractor: NSObject {

    // MARK: - Public Properties
    //
    weak var presenter: EntriesPresenter!
    var entriesCollection: EntriesCollection?
    
    // MARK: - Private Properties
    //
    private var nextSliceAnchorItem: String?
    private var networkWorker: NetworkWorker?
    
    // MARK: - Public Methods
    //
    func requestEntries(fromNextSlice nextSlice: Bool) {
        
        if networkWorker == nil {
            networkWorker = NetworkWorker(withInteractor: self)
        }
        
        var url = Constants.kTopEntriesUrl
        if nextSlice {
            
            guard let nextSliceAnchorItem = self.nextSliceAnchorItem else {
                return
            }
            
            url = url + "?after=\(nextSliceAnchorItem)"
        }
        
        networkWorker?.performGetRequest(withURLString: url, completion: { [weak self] entries, nextSliceAnchorItem in
            
            if nextSlice {
                self?.entriesCollection?.addEntries(entries)
            } else {
                self?.entriesCollection = EntriesCollection(withEntries: entries)
            }
            
            self?.nextSliceAnchorItem = nextSliceAnchorItem
            
            self?.presenter.present()
        })
    }
}
