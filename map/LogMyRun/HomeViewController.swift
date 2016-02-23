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


    //@IBOutlet weak var runnerTransmit: UIButton!
    //@IBOutlet weak var runnerTransmit: UISwitch!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        
        //self.tabBarItem.image = [[UIImage imageNamed:@"yourImage_image"]
        //imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //var scrollView: UIScrollView!
        //var imageView: UIImageView!
        

        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeImage"), selectedImage: UIImage(named: "homeIcon_white")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem

        super.viewDidLoad()
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
