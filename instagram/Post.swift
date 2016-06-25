//
//  Post.swift
//  instagram
//
//  Created by Dimple Jethani on 6/21/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import Foundation
import Parse
class Post{
    func postUserVideo (videoFile:PFFile, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?){
        
        let post = PFObject(className: "Post")

        
        post["media"] = videoFile // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        post.saveInBackgroundWithBlock(completion)
        
        
    }
    func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        post.saveInBackgroundWithBlock(completion)
        
    }
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}