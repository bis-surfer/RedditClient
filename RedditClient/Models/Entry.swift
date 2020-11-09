//
//  Entry.swift
//  RedditClient
//
//  Created by Ilya Borisov on 07.11.2020.
//

import UIKit

class Entry: NSObject {

    // MARK: - Public Properties
    //
    var title: String = ""
    var author: String = ""
    var created_utc_timestamp: Int?
    var commentsCount: Int = 0
    var thumbnailUrl: String?
    var pictureUrl: String?
    
    // MARK: - Life cycle
    //
    init(withTitle title: String, author: String, created_utc_timestamp: Int?, commentsCount: Int, thumbnailUrl: String?, pictureUrl: String?) {
        
        self.title = title
        self.author = author
        self.created_utc_timestamp = created_utc_timestamp
        self.commentsCount = commentsCount
        self.thumbnailUrl = thumbnailUrl
        self.pictureUrl = pictureUrl
    }
    
    // MARK: - Public Methods
    //
    func creationDateFormatted() -> String {
        
        guard let creation_utc_timestamp = created_utc_timestamp else {
            return ""
        }
        
        let creationDate = NSDate(timeIntervalSince1970: TimeInterval(creation_utc_timestamp))
        
        let secondsSinceCreationTillNow: TimeInterval = 0.0 - creationDate.timeIntervalSinceNow
        let minutesSinceCreationTillNow = secondsSinceCreationTillNow / 60.0
        let hoursSinceCreationTillNow = minutesSinceCreationTillNow / 60.0
        
        return " - \(Int(hoursSinceCreationTillNow)) hours ago"
    }
}
