//
//  FooterView.swift
//  RedditClient
//
//  Created by Ilya Borisov on 10.11.2020.
//

import UIKit

class FooterView: UIView {

    // MARK: - Outlets
    //
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var nextEntriesButton: UIButton!
    
    // MARK: - Public Methods
    //
    func showActivityIndicator(_ show: Bool) {
        
        if show {
            activityIndicatorView.show()
        } else {
            activityIndicatorView.hide()
        }
        
        nextEntriesButton.isHidden = show
    }
}
