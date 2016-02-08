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
