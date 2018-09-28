//
//  InstagramPostTableViewCell.swift
//  instagram
//
//  Created by Andre Campbell on 9/24/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class InstagramPostCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var mediaView: PFImageView!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var instagramPost: Post! {
        didSet {
            self.mediaView.file = instagramPost.media
            self.mediaView.loadInBackground()
            self.authorLabel.text = instagramPost.author.username
            self.captionLabel.text = instagramPost.caption
            self.likesCountLabel.text = String(instagramPost.likesCount) 
            
        }
    }
}
