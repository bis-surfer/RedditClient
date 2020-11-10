//
//  EntriesViewController+StateRestoration.swift
//  RedditClient
//
//  Created by Ilya Borisov on 11.11.2020.
//

import UIKit

extension EntriesViewController {

    // Keys for restoring this view controller.
    static let entriesInteractorKey = "entriesInteractor"
    static let entriesPresenterKey = "entriesPresenter"
    static let selectedEntryKey = "selectedEntry"

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(entriesInteractor, forKey: EntriesViewController.entriesInteractorKey)
        coder.encode(entriesPresenter, forKey: EntriesViewController.entriesPresenterKey)
        coder.encode(selectedEntry, forKey: EntriesViewController.selectedEntryKey)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        entriesInteractor = coder.decodeObject(forKey: EntriesViewController.entriesInteractorKey) as? EntriesInteractor
        entriesPresenter = coder.decodeObject(forKey: EntriesViewController.entriesPresenterKey) as? EntriesPresenter
        selectedEntry = coder.decodeObject(forKey: EntriesViewController.selectedEntryKey) as? Entry
    }
}
