//
//  EntriesViewController+UITableViewDataSource.swift
//  RedditClient
//
//  Created by Ilya Borisov on 07.11.2020.
//

import UIKit

extension EntriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        entriesPresenter.entriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rawCell = tableView.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath)
        
        guard let cell = rawCell as? EntryTableViewCell else {
            print("Got mismatched type for dequeued cell. Expected: \(EntryTableViewCell.self), received: \(rawCell.self)")
            return rawCell
        }
        
        guard let entry = entriesPresenter.entry(atIndex: indexPath.row) else {
            print("Couldn't get EntryTableViewCell at indexPath: \(indexPath)")
            return cell
        }
        
        cell.configure(withEntry: entry)
        setupThumbnail(withURL: entry.thumbnailUrl, forCell: cell, atIndexPath: indexPath)
        
        return cell
    }
}


// MARK: - Images Download and Display

extension EntriesViewController {
    
    func setupThumbnail(withURL thumbnailUrl: String?, forCell cell: EntryTableViewCell, atIndexPath indexPath: IndexPath) {
        
        entriesInteractor.setupImageView(cell.thumbnailImageView, withImageUrl: thumbnailUrl, defaultImage: nil, showPlaceholderBlock: { showImagePlaceholderView(forCell: cell, atIndexPath: indexPath) }, hidePlaceholderBlock: { self.hideImagePlaceholderView(forCell: cell, atIndexPath: indexPath) })
    }
    
    func showImagePlaceholderView(forCell cell: EntryTableViewCell, atIndexPath indexPath: IndexPath) {

        cell.showImagePlaceholderView()
    }
    
    func hideImagePlaceholderView(forCell cell: EntryTableViewCell, atIndexPath indexPath: IndexPath) {
        
        cell.hideImagePlaceholderView()
        entriesTableView.reloadRows(at: [indexPath], with: .none)
    }
}
