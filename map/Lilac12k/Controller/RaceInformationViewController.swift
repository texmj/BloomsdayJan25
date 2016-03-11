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
    
    @IBOutlet weak var Schedule: UIButton!
    @IBOutlet weak var Parking: UIButton!
    @IBOutlet weak var TrainingTips: UIButton!
    @IBOutlet weak var Registration: UIButton!
    @IBOutlet weak var Bloomsday40: UIButton!
    @IBOutlet weak var FAQ: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func Schedule(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/race-information/weekend-schedule") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func Parking(sender: AnyObject) {
        if let url = NSURL(string: "http://www.downtownspokane.org/documents/ParkingMap2010.pdf") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func TrainingTips(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/training/training-program") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func Registration(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/registration/register-online") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func Bloomsday40(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/40th-year-video") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func FAQ(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/faq") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
}