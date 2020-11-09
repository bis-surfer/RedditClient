//
//  ImagesDownloadManager.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit

class ImagesDownloadManager: NSObject {

    static var _sharedInstance: ImagesDownloadManager? = nil
    
    class func sharedInstance() -> ImagesDownloadManager {
        
        if _sharedInstance == nil {
            
            _sharedInstance = ImagesDownloadManager()
        }
        
        return _sharedInstance!
    }
    
    
    var images: [String : ImageRecord] = [:]
    
    
    lazy var imagesDownloadQueue: OperationQueue = {
        
        var queue = OperationQueue()
        
        queue.name = "Images Download Queue"
        
        // queue.maxConcurrentOperationCount = 1
        
        return queue
    } ()
    
    
    // MARK: - NSObject method(s)
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - ImagesDownloadManager methods
    
    func imageNamed(_ imageName: String) -> ImageRecord? {
        
        return images[imageName]
    }
    
    func startDownload(forImageRecord imageRecord: ImageRecord, withCompletionBlock completionBlock: @escaping (() -> Void)) {
        
        images[imageRecord.name] = imageRecord
        
        let imageDownloadingOperation = ImageDownloadingOperation(withImageRecord: imageRecord)
        imageDownloadingOperation.completionBlock = completionBlock
        
        imagesDownloadQueue.addOperation(imageDownloadingOperation)
    }
    
    
    func setupImageView(_ imageView: UIImageView, withImageUrl imageUrl: String, defaultImage: UIImage?, showPlaceholderBlock: (() -> Void), hidePlaceholderBlock: @escaping (() -> Void)) {
        
        var imageRecord: ImageRecord? = sharedImagesDownloadManager.imageNamed(imageUrl)
        
        if imageRecord != nil {
            
            if imageRecord!.image != nil {
                
                imageView.image = imageRecord!.image
            }
            else {
                
                showPlaceholderBlock()
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name(Constants.kImageWasDownloadedNotification), object: imageRecord, queue: nil, using: {_ in
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = imageRecord!.image
                        hidePlaceholderBlock()
                    })
                })
            }
        }
        else {
            
            guard imageUrl != "default" else {
                return
            }
            
            imageRecord = ImageRecord(withImageUrl: imageUrl)
            
            showPlaceholderBlock()
            sharedImagesDownloadManager.startDownload(forImageRecord: imageRecord!, withCompletionBlock: {
                
                DispatchQueue.main.async {
                    
                    imageView.image = imageRecord!.image
                    hidePlaceholderBlock()
                }
            })
        }
    }
}
