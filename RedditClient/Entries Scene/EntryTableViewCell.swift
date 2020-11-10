//
//  EntryTableViewCell.swift
//  RedditClient
//
//  Created by Ilya Borisov on 07.11.2020.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    //
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = nil
        authorLabel.text = nil
        commentsCountLabel.text = nil
        thumbnailImageView.image = nil
        thumbnailImageView.isHidden = false
        activityIndicatorView.hide()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        authorLabel.text = nil
        commentsCountLabel.text = nil
        thumbnailImageView.image = nil
        thumbnailImageView.isHidden = false
        activityIndicatorView.hide()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public Methods
    //
    func configure(withEntry entry: Entry) {
        
        titleLabel.text = entry.title
        authorLabel.text = entry.author + entry.creationDateFormatted()
        
        var commentsCountString = "\(entry.commentsCount) comment"
        if entry.commentsCount != 1 {
            commentsCountString = commentsCountString + "s"
        }
        commentsCountLabel.text = commentsCountString
    }
    
    func showImagePlaceholderView() {
        
        thumbnailImageView.isHidden = true
        activityIndicatorView.show()
    }
    
    func hideImagePlaceholderView() {
        
        thumbnailImageView.isHidden = false
        activityIndicatorView.hide()
    }
}
