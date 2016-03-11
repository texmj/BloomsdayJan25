//
//  MainTabBarController.swift
//  LogMyRun
//
//  Created by Kaitlin Anderson on 2/8/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation

class MainTabBarController: UITabBarController  {
    
    //var managedObjectContext : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MAINTABBARCONTROLLER")
        //get the reference to the shared model
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 109/255, green: 34/255, blue: 117/255, alpha: 1.0) ], forState:.Normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        
        //let tabBarController: MainTabBarController = (self.window!.rootViewController as! MainTabBarController)
        let tabBar: UITabBar = self.tabBar
        let firstTab: UITabBarItem = tabBar.items![0]
        let secondTab: UITabBarItem = tabBar.items![1]
        let thirdTab: UITabBarItem = tabBar.items![2]
        let fourthTab: UITabBarItem = tabBar.items![3]
        let fifthTab: UITabBarItem = tabBar.items![4]
        
        firstTab.image = UIImage(named: "homeImage")!.imageWithRenderingMode(.AlwaysOriginal)
        //let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon_white"), selectedImage: UIImage(named: "homeImage"))
        firstTab.selectedImage = UIImage(named: "homeIcon_white")!.imageWithRenderingMode(.AlwaysOriginal)
        
        secondTab.image = UIImage(named: "infoIcon")!.imageWithRenderingMode(.AlwaysOriginal)
        secondTab.selectedImage = UIImage(named: "infoIcon_white")!.imageWithRenderingMode(.AlwaysOriginal)
        
        thirdTab.image = UIImage(named: "mapIcon")!.imageWithRenderingMode(.AlwaysOriginal)
        thirdTab.selectedImage = UIImage(named: "mapIcon_white")!.imageWithRenderingMode(.AlwaysOriginal)
        
        fourthTab.image = UIImage(named: "friendsIcon")!.imageWithRenderingMode(.AlwaysOriginal)
        fourthTab.selectedImage = UIImage(named: "friendsIcon_white")!.imageWithRenderingMode(.AlwaysOriginal)
        
        fifthTab.image = UIImage(named: "flagIcon")!.imageWithRenderingMode(.AlwaysOriginal)
        fifthTab.selectedImage = UIImage(named: "flagIcon_white")!.imageWithRenderingMode(.AlwaysOriginal)
        
        
        UITabBar.appearance().tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)


    }
    override func viewDidAppear(animated: Bool) {
        //      FacebookImages.sharedInstance
    }
    
    
    
}
