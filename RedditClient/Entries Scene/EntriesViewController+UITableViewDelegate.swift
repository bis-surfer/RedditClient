//
//  EntriesViewController+UITableViewDelegate.swift
//  RedditClient
//
//  Created by Illia Borysov on 09.11.2020.
//

import UIKit

extension EntriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard let entry = entriesPresenter.entry(atIndex: indexPath.row) else {
            print("Couldn't get Entry at indexPath: \(indexPath)")
            return indexPath
        }
        
        selectedEntry = entry
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return footerView
    }
}
