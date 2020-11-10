//
//  EntriesCollection.swift
//  RedditClient
//
//  Created by Ilya Borisov on 07.11.2020.
//

import UIKit

class EntriesCollection: NSObject {

    // MARK: - Private Properties
    //
    private var entries: [Entry] = []
    
    // MARK: - Life cycle
    //
    init(withEntries entries: [Entry]?) {
        
        self.entries = entries ?? []
    }
    
    // MARK: - Public Methods
    //
    func addEntries(_ entries: [Entry]?) {
        
        guard let entriesToAdd = entries else {
            return
        }
        
        self.entries.append(contentsOf: entriesToAdd)
    }
    
    func entriesCount() -> Int {
        return entries.count
    }
    
    func entry(atIndex entryIndex: Int) -> Entry? {
        guard entryIndex < entries.count else {
            return nil
        }
        
        return entries[entryIndex]
    }
}
