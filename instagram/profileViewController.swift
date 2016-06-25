//
//  profileViewController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/21/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit
import Parse

class profileViewController: UIViewController, UIViewControllerTransitioningDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var bio: UITextField!
    
   
    
   
    let picker = UIImagePickerController()
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        picker.delegate = self
            
            // Do any additional setup after loading the view.
    }

        // Do any additional setup after loading the view.
    @IBAction func Submit(sender: AnyObject) {
        print("posting")
        
        let im = resize(imageView2.image!, newSize: imageView2.image!.size)
        
        PFUser.currentUser()!["picture"] = NSData(data: UIImagePNGRepresentation(im)!)
        
        PFUser.currentUser()!["bio"] = bio.text
        print("I'm Here")
        
        PFUser.currentUser()!.saveInBackgroundWithBlock(
            {(succeeded: Bool, error: NSError?) -> Void in
                if succeeded == true{
                    print("saved")
                }
                else{
                    print("ERROR ERROR", error)
                }
        })
        print("posted #2")
        

    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func editProfPicture(sender: AnyObject) {
        let title = "Update Your Profile Picture"
        let message="Choose An Option Below"
        
        let option1 = "Take Profile Picture"
        let option2 = "Select Profile Picture"
    //    let option3 = "Edit Your Bio"
        let option4 = "Cancel"
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let action1 = UIAlertAction(title: option1, style: .Default, handler: {(_)->Void in
            self.takePicture()})
        
        
        let action2 = UIAlertAction(title: option2, style: .Default, handler: {(_)->Void in
            self.findPicture()})
        
    //    let action3 = UIAlertAction(title: option3, style: .Default, handler: {(_)->Void in
          //  self.findPicture()})
        
        let action4 = UIAlertAction(title: option4, style: .Cancel, handler: nil)
        
        actionSheet.addAction(action1)
        
        actionSheet.addAction(action2)
 
        actionSheet.addAction(action4)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        

    }
    
    
    
    
    
   
    func takePicture(){
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
                picker.allowsEditing=false
                picker.sourceType=UIImagePickerControllerSourceType.Camera
                picker.cameraCaptureMode = .Photo
                picker.modalPresentationStyle = .FullScreen
                presentViewController(picker, animated: true, completion: nil)
            }
            else{
                noCamera()
            }
    }
    func findPicture(){
            picker.allowsEditing = false
            picker.sourceType = .PhotoLibrary
            picker.modalPresentationStyle = .Popover
            presentViewController(picker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView2.contentMode = .ScaleAspectFit
        imageView2.image = chosenImage

     //   imageView.contentMode = .ScaleAspectFit
      //  imageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "This device doesn't have camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction (
            title: "OK",
            style:.Default,
            handler:nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated:true, completion:nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
