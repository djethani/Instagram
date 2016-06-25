//
//  tabBarController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/23/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//
import UIKit

class tabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barStyle = UIBarStyle.Black
        tabBar.barTintColor = UIColor.blackColor()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
