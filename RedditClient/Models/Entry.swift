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
    var commentsCount: Int = 0
    var thumbnailUrl: String?
    
    // MARK: - Life cycle
    //
    init(withTitle title: String, author: String, commentsCount: Int, thumbnailUrl: String?) {
        self.title = title
        self.author = author
        self.commentsCount = commentsCount
        self.thumbnailUrl = thumbnailUrl
    }
}
