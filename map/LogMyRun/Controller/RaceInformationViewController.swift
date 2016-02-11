//
//  RaceInformationViewController.swift
//  LogMyRun
//
//  Created by Sarah Prata on 2/9/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation


import UIKit

class RaceInformationViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RaceInfo")

        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Info", image: UIImage(named: "infoIcon"), selectedImage: UIImage(named: "infoIcon_white")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
    }
    
    
    
}