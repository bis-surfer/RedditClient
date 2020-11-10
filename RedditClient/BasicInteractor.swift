//
//  BasicInteractor.swift
//  RedditClient
//
//  Created by Ilya Borisov on 10.11.2020.
//

import UIKit

class BasicInteractor: NSObject {

    // MARK: - Public Methods
    //
    func setupImageView(_ imageView: UIImageView, withImageUrl imageUrl: String?, defaultImage: UIImage?, showPlaceholderBlock: (() -> Void), hidePlaceholderBlock: @escaping (() -> Void)) {
        
        guard let imageUrl = imageUrl else {
            return
        }
        
        sharedImagesDownloadManager.setupImageView(imageView, withImageUrl: imageUrl, defaultImage: nil, showPlaceholderBlock: { showPlaceholderBlock() }, hidePlaceholderBlock: { hidePlaceholderBlock() })
    }
}
