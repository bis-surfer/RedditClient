//
//  ImageDownloadingOperation.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit

class ImageDownloadingOperation: Operation {
    
    let imageRecord: ImageRecord
    
    init(withImageRecord imageRecord: ImageRecord) {
        
        self.imageRecord = imageRecord
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        
        guard imageRecord.name != "default" else {
            return
        }
        
        let imageURL: URL = imageRecord.url
        
        imageRecord.state = .downloading
        
        guard let imageData: Data = try? Data(contentsOf: imageURL) else {
            
            imageRecord.state = .failed
            return
        }
        
        if isCancelled {
            return
        }
        
        if imageData.isEmpty {
            
            imageRecord.state = .failed
        }
        else {
            
            imageRecord.state = .downloaded
            var image: UIImage? = UIImage(data:imageData, scale: 1.0)
            
            if image == nil {
                
                let imageDataAsBase64EncodedString: String = imageData.base64EncodedString()
                
                let decodedImageData: Data? = Data(base64Encoded: imageDataAsBase64EncodedString, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                
                if decodedImageData != nil {
                    
                    image = UIImage(data: decodedImageData!, scale: 1.0)
                }
            }
            
            imageRecord.image = image
            
            NotificationCenter.default.post(name: NSNotification.Name(Constants.kImageWasDownloadedNotification), object: imageRecord)
        }
    }
}
