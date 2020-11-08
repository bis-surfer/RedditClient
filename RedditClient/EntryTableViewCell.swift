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
    
    // MARK: - Life cycle
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public Methods
    //
    func configure(withEntry entry: Entry) {
        titleLabel.text = entry.title
    }

}
