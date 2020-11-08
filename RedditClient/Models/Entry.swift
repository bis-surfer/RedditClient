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
    
    // MARK: - Life cycle
    //
    init(withTitle title: String) {
        self.title = title
    }
}
