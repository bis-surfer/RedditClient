//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Illia Borysov on 09.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    //
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Public Properties
    //
    var entry: Entry?
    
    // MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let thumbnailUrl = entry?.thumbnailUrl else {
            return
        }
        
        sharedImagesDownloadManager.setupImageView(imageView, withImageUrl: thumbnailUrl, defaultImage: nil, showPlaceholderBlock: { }, hidePlaceholderBlock: { })
    }
}
