//
//  HomeViewController.swift
//  LogMyRun
//
//  Created by Kaitlin Anderson on 2/4/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import UIKit
import Foundation
import Darwin
class HomeViewController : UIViewController{

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var runHistory: UIButton!
    @IBOutlet weak var days: UILabel!

    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
    //@IBOutlet weak var runnerTransmit: UIButton!
    //@IBOutlet weak var runnerTransmit: UISwitch!
    /*
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
*/
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var startButton: UIButton!
    var timer = NSTimer();
    override func viewDidLoad() {
        
        //self.tabBarItem.image = [[UIImage imageNamed:@"yourImage_image"]
        //imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //var scrollView: UIScrollView!
        //var imageView: UIImageView!
        timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: "update", userInfo: nil, repeats: true)

        //let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeImage"), selectedImage: UIImage(named: "homeIcon_white")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        /*let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon_white"), selectedImage: UIImage(named: "homeImage"))
        self.tabBarItem = customTabBarItem*/

        super.viewDidLoad()
        
        let bloomsdayDate = 1462093200.0
        let timeLeft = bloomsdayDate - NSDate().timeIntervalSince1970
        let daysNum  = Double((ceil( timeLeft / 86400.0)))//43200.0)))
        days.text = String(Int(daysNum))
        let hourNum = floor( 23 - ((((timeLeft % 86400.0) / 3600.0) - 8))%24) //Greenwich is 8 hours ahead of us
        hours.text = formatDate(Int(hourNum))

        let minNum = floor( ((timeLeft % 3600.0) / 60.0))
        minutes.text = formatDate(Int(minNum))
        let baseHeight = runHistory.frame.origin.y + 150;
        /*if(baseHeight < self.viewIfLoaded!.frame.height )
        {
            baseHeight = self.viewIfLoaded!.frame.height
        }*/
        //let scrollWidth = self.viewIfLoaded!.frame.size.width - 20;

        scroller.contentSize = CGSizeMake(0, baseHeight)//2300
        

        /*
        let switchDemo=UISwitch(frame:CGRectMake(150, 300, 0, 0));
        switchDemo.on = true
        switchDemo.setOn(true, animated: false);
        switchDemo.addTarget(self, action: "switchValueDidChange:", forControlEvents: .ValueChanged);
        self.view.addSubview(switchDemo);
        
        imageView = UIImageView(image: UIImage(named: "facebook-default-no-profile-pic.jpg"))
        
        scrollView = UIScrollView(frame: CGRectMake(10, switchDemo.frame.maxY, self.view.frame.maxX-20, self.view.frame.maxY-switchDemo.frame.maxY-50))//view.bounds)
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = CGSizeMake(self.view.frame.width-30, 624); //imageView.bounds.size
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth //| UIViewAutoresizing.FlexibleHeight
        //scrollView.contentOffset = CGPoint(x: 1000, y: 450)
        scrollView.addSubview(imageView)
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "I'am a test label"
        scrollView.addSubview(label)
        
        //scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        */
        
    }
    
    
    override func viewDidLayoutSubviews() {
        scroller.scrollEnabled = true
        // Do any additional setup after loading the view
        //scroller.size
        //scroller.contentSize = CGSizeMake(400, 2300)
    }

    func update() {
        // Something cool
        let min = (Int(self.minutes.text!)! - 1)%60;
        if(min == 0)
        {
            minutes.text = "60"
            let hour = (Int(self.hours.text!)! - 1)%24;
            if(hour == 0 )
            {
                hours.text = "24"
                let day = (Int(self.days.text!)! - 1);
                days.text = String(day);
            }
            else
            {
                hours.text = formatDate(hour);
            }
        }
        else
        {
            minutes.text = formatDate(min);
        }
    }
    
    func formatDate(time: Int) -> String
    {
        if(time < 10)
        {
            return("0"+String(time));
        }
        else
        {
            return(String(time))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
        if (sender.on == true){
            UserInformation.sharedInstance.isRunnerTransmittingData = true
        }
        else{
            UserInformation.sharedInstance.isRunnerTransmittingData = false
        }
    }
    
    //this class is not key value coding-compliant for the key runnerTransmit
    /*func stateChanged(runnerTransmit: UISwitch!)
    {
        print("Runner Switch Changed")
        if (runnerTransmit.on == true){
            UserInformation.sharedInstance.isRunnerTransmittingData = true
        }
        else{
            
            UserInformation.sharedInstance.isRunnerTransmittingData = false
        }
    }*/
    
    



}
