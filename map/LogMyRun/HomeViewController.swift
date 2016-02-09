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

    
    
    
    override func viewDidLoad() {
        //super viewDidLoad()
        
        //self.tabBarItem.image = [[UIImage imageNamed:@"yourImage_image"]
        //imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        FacebookImages.sharedInstance
/*
        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "house_white25x25.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "homeImage")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
  */      
        /*
       
        let userCalendar = NSCalendar.currentCalendar()
    
        
        let bloomsdayComponents = NSDateComponents()
        bloomsdayComponents.year = 2016
        bloomsdayComponents.month = 5
        bloomsdayComponents.day = 1
       let bloomsdayDay = userCalendar.dateFromComponents(bloomsdayComponents)!
        
        _ = userCalendar.components([.Day], .Hour, .Minute, fromDate: NSDate(),
            toDate: bloomsdayDay,
            options: [])
        
        
        let dayCalendarUnit: NSCalendarUnit = [.Day]
        let bloomsdayDayDifference = userCalendar.components(
            dayCalendarUnit,
            fromDate: NSDate(),
            toDate: bloomsdayDay,
            options: [])
       bloomsdayDayDifference.day //WHYYYYY
        
        

        
        days.text = String(bloomsdayComponents.day)
        hours.text = String(bloomsdayComponents.hour)
        minutes.text = String(bloomsdayComponents.minute)
      

        */
        super.viewDidLoad()
    }



}
