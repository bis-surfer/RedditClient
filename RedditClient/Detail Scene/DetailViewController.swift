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
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var pictureView: UIImageView!
    
    // MARK: - Public Properties
    //
    var detailInteractor: DetailInteractor!
    var entry: Entry?
    
    // MARK: - Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailInteractor = DetailInteractor()
        
        setupPicture()
    }
}


// MARK: - Images Download and Display

extension DetailViewController {
    
    func setupPicture() {
        
        guard let pictureUrl = entry?.pictureUrl else {
            
            hideImagePlaceholderView()
            return
        }
        
        detailInteractor.setupImageView(pictureView, withImageUrl: pictureUrl, defaultImage: nil, showPlaceholderBlock: { showImagePlaceholderView() }, hidePlaceholderBlock: { self.hideImagePlaceholderView() })
    }
    
    func showImagePlaceholderView() {
        
        pictureView.isHidden = true
        activityIndicatorView.show()
    }

    func hideImagePlaceholderView() {
        
        pictureView.isHidden = false
        activityIndicatorView.hide()
    }
}
