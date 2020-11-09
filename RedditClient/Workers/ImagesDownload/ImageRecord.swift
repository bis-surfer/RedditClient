//
//  ImageRecord.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit


enum ImageRecordState: Int {
    
    case new, downloading, downloaded, failed
}


class ImageRecord: NSObject {
    
    let name: String
    let url: URL
    var state: ImageRecordState = ImageRecordState.new
    var image: UIImage? = nil
    
    init(withImageUrl imageUrlString: String) {
        
        name = imageUrlString
        url = URL(string: imageUrlString)!
    }
}
