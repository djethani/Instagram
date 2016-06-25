//
//  navBarController.swift
//  instagram
//
//  Created by Dimple Jethani on 6/23/16.
//  Copyright © 2016 Dimple Jethani. All rights reserved.
//

import UIKit

class navBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.blueColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
