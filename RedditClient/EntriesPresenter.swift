//
//  EntriesPresenter.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit

protocol EntriesViewReloadable: class {
    func reload()
}

class EntriesPresenter: NSObject {

    // MARK: - Public Properties
    //
    var entriesCollection: EntriesCollection?
    
    // MARK: - Private Properties
    //
    private weak var viewController: EntriesViewReloadable?
    private weak var interactor: EntriesInteractor!
    
    // MARK: - Life cycle
    //
    init(withViewController viewController: EntriesViewReloadable, interactor: EntriesInteractor) {
        
        self.viewController = viewController
        self.interactor = interactor
    }
    
    // MARK: - Public Methods
    //
    func present() {
        
        entriesCollection = interactor.entriesCollection
        
        viewController?.reload()
    }
    
    func entriesCount() -> Int {
        return entriesCollection?.entriesCount() ?? 0
    }
    
    func entry(atIndex entryIndex: Int) -> Entry? {
        return entriesCollection?.entry(atIndex: entryIndex)
    }
}
