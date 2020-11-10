//
//  DetailViewController+StateRestoration.swift
//  RedditClient
//
//  Created by Ilya Borisov on 11.11.2020.
//

import UIKit

extension DetailViewController {

    // Keys for restoring this view controller.
    static let entryKey = "entry"
    static let imageKey = "image"

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(entry, forKey: DetailViewController.entryKey)
        coder.encode(pictureView.image, forKey: DetailViewController.imageKey)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        entry = coder.decodeObject(forKey: DetailViewController.entryKey) as? Entry
        if let image = coder.decodeObject(forKey: DetailViewController.imageKey) as? UIImage {
            pictureView.image = image
        }
    }
}
