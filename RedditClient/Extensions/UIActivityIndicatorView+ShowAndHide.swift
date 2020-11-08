//
//  UIActivityIndicatorView+ShowAndHide.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit


extension UIActivityIndicatorView {
    
    func show() {
        
        isHidden = false
        
        if !isAnimating {
            startAnimating()
        }
    }
    
    func hide() {
        
        isHidden = true
        
        if isAnimating {
            stopAnimating()
        }
    }
}
