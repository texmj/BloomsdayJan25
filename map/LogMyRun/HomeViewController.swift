//
//  HomeViewController.swift
//  LogMyRun
//
//  Created by Kaitlin Anderson on 2/4/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import UIKit
import Foundation
class HomeViewController : UIViewController{


    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        
        //self.tabBarItem.image = [[UIImage imageNamed:@"yourImage_image"]
        //imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        FacebookImages.sharedInstance

        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeImage"), selectedImage: UIImage(named: "homeIcon_white")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem

        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        
        

    }
    



}
