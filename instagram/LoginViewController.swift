//
//  LoginViewController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/20/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
    
        
    PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error:NSError?) -> Void in
            if user != nil {
                print("you're logged in!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else{
                print("Please Register")
            }
        }
    }

    
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("performing segue: \(segue.identifier)")
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
