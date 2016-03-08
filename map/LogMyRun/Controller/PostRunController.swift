//
//  PostRunController.swift
//  LogMyRun
//
//  Created by Kaitlin Anderson on 1/28/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import UIKit

class PostRunController : UIViewController{

    @IBOutlet weak var GoodieBag: UIButton!
    @IBOutlet weak var Results:  UIButton!
    @IBOutlet weak var Facebook: UIButton!
    @IBOutlet weak var Sponsors: UIButton!
    @IBOutlet weak var RacePhotos: UIButton!
    
    @IBAction func GoodieBag(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/virtual-race-bags") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func Results(sender: AnyObject) {
        if let url = NSURL(string: "http://bloomsdayrun.org/results/all-finishers") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func Facebook(sender: AnyObject) {
        if let url = NSURL(string: "http://www.facebook.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func Sponsors(sender: AnyObject) {
        if let url = NSURL(string: "https://www.bloomsdayrun.org/sponsors/bloomsday-sponsors") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func RacePhotos(sender: AnyObject) {
        if let url = NSURL(string: "https://www.bloomsdayrun.org/race-photos") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }



}