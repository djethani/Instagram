//
//  ShowSplashScreen.swift
//  instagram
//
//  Created by Dimple Jethani on 6/22/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit

class ShowSplashScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(Selector ("showNavController"), withObject: nil, afterDelay: 3)
        // Do any additional setup after loading the view.
    }
    
    func showNavController(){
        performSegueWithIdentifier("splashScreenShow", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
