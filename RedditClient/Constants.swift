//
//  Constants.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit


let sharedImagesDownloadManager = ImagesDownloadManager.sharedInstance()


class Constants: NSObject {

    static let kTopEntriesUrl = "https://www.reddit.com/top.json"
    
    static let kImageWasDownloadedNotification = "ImageWasDownloadedNotification"
}
