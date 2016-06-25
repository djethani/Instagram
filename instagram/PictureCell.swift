//
//  PictureCell.swift
//  instagram
//
//  Created by Dimple Jethani on 6/22/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class PictureCell: UITableViewCell {
  
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var posterView: PFImageView!

    
    var instagramPost: PFObject! {
        didSet {
            posterView.file = instagramPost["media"] as? PFFile
            posterView.loadInBackground()
            
            userLabel.text=instagramPost["author"].username
            likeCount.text=String(instagramPost["likesCount"])
            let time = instagramPost.createdAt
            print("TIME", time)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            
            let string = dateFormatter.stringFromDate(time!)
            timeStamp.text = string
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
