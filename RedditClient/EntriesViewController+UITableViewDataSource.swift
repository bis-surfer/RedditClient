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
        
        return cell
    }
    
}
