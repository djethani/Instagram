//
//  cellDetailsView.swift
//  instagram
//
//  Created by Dimple Jethani on 6/22/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class cellDetailsView: UIViewController {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var image: PFImageView!
    
    var username:String? = ""
    var caption_words:String = ""
    var like_count:String = ""
    
    var post:PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeCount.text=like_count
        userLabel.text=username
        caption.text = caption_words
      //  caption?.backgroundColor = UIColor(white: 1, alpha: 0.2)
        image.file = post["media"] as? PFFile
        image.loadInBackground()
        let time = post.createdAt
       
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        let string = dateFormatter.stringFromDate(time!)
         date.text = string

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
