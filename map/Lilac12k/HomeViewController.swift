//
//  HomeViewController.swift
//  Lilac12k
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
    @IBOutlet weak var welcomeMessage: UILabel!
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
        print("HOMEVIEWCONTROLLER")

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
        
        let model = UIDevice.currentDevice().modelName
        let currentFont = welcomeMessage.font
        var sizeScale: CGFloat = 1.0;
        //print("\n\nMODEL:", model)
        if model == "iPhone 6" {
            sizeScale = 1.3
        }
        else if model == "iPhone 6s Plus" {
            sizeScale = 1.5
        }
        else if model == "Simulator" {
            sizeScale = 1.0
        }
        welcomeMessage.font = currentFont.fontWithSize(currentFont.pointSize * sizeScale)

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
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

extension UILabel {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let model = UIDevice.currentDevice().modelName
                
                if model == "iPhone 6" {
                    sizeScale = 1.3
                }
                else if model == "iPhone 6 Plus" {
                    sizeScale = 3//1.5
                }
                self.font = currentFont.fontWithSize(currentFont.pointSize * sizeScale)
            }
        }
        
        get {
            return false
        }
    }
}

