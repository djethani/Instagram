//
//  RegisterViewController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/22/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBAction func onRegister(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        
        newUser.password = passwordField.text
        newUser["email"] = emailField.text
        
        let image = UIImage(named: "camera.png")
        
        newUser["picture"] = NSData(data: UIImagePNGRepresentation(image!)!)
        
        newUser["bio"]=""
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?)-> Void in
            if success {
                print("Created a user")
            self.performSegueWithIdentifier("registerSegue", sender: nil)
            } else{
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print ("Username is taken")
                }
            }
        }

    }
}
