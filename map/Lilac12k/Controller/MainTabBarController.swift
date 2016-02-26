//
//  MainTabBarController.swift
//  Lilac12k
//
//  Created by Kaitlin Anderson on 2/8/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation

class MainTabBarController: UITabBarController  {
    
    //var managedObjectContext : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the reference to the shared model
        
       // self.tabBarItem = UITabBarItem(title: "Finish", image: UIImage(named: "flagIcon_white"), selectedImage: UIImage(named: "flagIcon"))
        

        
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 109/255, green: 34/255, blue: 117/255, alpha: 1.0) ], forState:.Normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)

        

        
        //let Finish:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "flag_white25x25.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "flagIcon"))

    }
    override func viewDidAppear(animated: Bool) {
        FacebookImages.sharedInstance
    }
    
    
    
}
