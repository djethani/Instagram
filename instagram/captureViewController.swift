//
//  captureViewController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/20/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit
import Parse
import MobileCoreServices

class captureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    @IBOutlet weak var videoLabel: UILabel!
    var isVideo = false
    @IBOutlet weak var imageView: UIImageView!
    var moviePath:String = ""
    let picker = UIImagePickerController()
    
    @IBOutlet weak var captionField: UITextField!
    
    
    @IBAction func submitImageAndCaption(sender: AnyObject) {
        /*if isVideo {
            let p = Post()
            let videoData = NSData(contentsOfFile:moviePath)
            
            let videoFile:PFFile = PFFile(name: moviePath , data:videoData!)!
        
            p.postUserVideo(videoFile, withCaption: captionField.text, withCompletion: nil)
        }
        else{
        */
            if imageView != nil {
        
                let p = Post()
                p.postUserImage(imageView.image, withCaption: captionField.text, withCompletion: nil)
            }
        
        self.performSegueWithIdentifier("backToHome", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        // Do any additional setup after loading the view.
    }
   
    @IBAction func video(sender: AnyObject) {
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
            isVideo = true
            picker.allowsEditing=false
            picker.sourceType=UIImagePickerControllerSourceType.Camera
            picker.cameraDevice = UIImagePickerControllerCameraDevice.Rear //or Front
            picker.mediaTypes = [kUTTypeMovie as String];
            picker.videoMaximumDuration = 10
            picker.videoQuality = UIImagePickerControllerQualityType.TypeMedium
            self.presentViewController(picker, animated: true, completion: nil)
            
        }else{
            noCamera()
        }
    }
  
   
    @IBAction func endKeyboard(sender: AnyObject) {
         view.endEditing(true)
    }
   
    @IBAction func photoFromLibrary(sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
    
    }
   
    
    @IBAction func shootPhoto(sender: UIButton) {
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      /*
        if isVideo{
            let mediaType = info[UIImagePickerControllerMediaType] as! NSString
           
            if mediaType == kUTTypeMovie {
                guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
                moviePath=path
            }
            videoLabel.text="Video has been saved."
            
            dismissViewControllerAnimated(true, completion: nil)
        } else{
          */
            let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
            imageView.contentMode = .ScaleAspectFit
            imageView.image = chosenImage
            dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
 

}



     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


