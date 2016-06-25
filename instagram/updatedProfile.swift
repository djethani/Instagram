//
//  updatedProfile.swift
//  instagram
//
//  Created by Dimple Jethani on 6/24/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import Parse

class updatedProfile:  UIViewController {
    var arr: [PFObject] = []
    //var query = PFQuery(className:"User")
    var secondQuery = PFQuery (className: "Post")
    @IBOutlet weak var postsCollectionView: UICollectionView!
    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    @IBAction func logout(sender: AnyObject) {
        print("logging out")
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            
        }
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
        print("logged out")

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsCollectionView.dataSource = self
        
        
       
        if let imageData = PFUser.currentUser()!["picture"] as? NSData {
            if let image = UIImage(data: imageData) {
                profilePicture.image = image
            }
        }
//
        
        UserLabel.text = PFUser.currentUser()!["username"] as? String
        bioLabel.text = PFUser.currentUser()!["bio"] as? String
    
        
        
       secondQuery.orderByDescending("createdAt")
       secondQuery.includeKey("author")
        
        secondQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    self.arr.removeAll()
                    for object in objects {
                        if PFUser.currentUser()!.username == object["author"].username{
                            self.arr.append(object)
                            
                            print("THE USER", PFUser.currentUser()!.username)
                            
                        }
                    }
        
        
                }
 
 
            }
            else{
                print("SECOND QUERY ERROR", error)
            }
        }
       view.backgroundColor = UIColor.whiteColor()
}
}

extension updatedProfile: UICollectionViewDataSource {
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.arr.count
        }
        
        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = postsCollectionView.dequeueReusableCellWithReuseIdentifier("userPostCells", forIndexPath: indexPath) as! userPostCells
          //  cell.backgroundColor = UIColor.blackColor()
            let row = indexPath.row
            print("ROW IN COLLECTION VIEW", row)
            cell.posterImageView.file = arr[row]["media"] as? PFFile
            cell.posterImageView.loadInBackground()
            return cell
        }
 
}

