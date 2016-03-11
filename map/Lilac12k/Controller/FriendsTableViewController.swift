//
//  FriendsTableViewController.swift
//  Lilac12k
//
//  Created by Sarah Prata on 2/1/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation
//@IBOutlet var tableView: UITableView!

class FriendsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var friendImages = [UIImage]()
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //FacebookImages.sharedInstance //instantiate??
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //self.tableView.contentSize = ;
        self.tableView.scrollEnabled = true
        self.tableView.bounces = true;
        //self.tableView.frame.size.height = 200;
        //self.tableView.contentSize = CGSizeMake(0, 800)

        self.view.bringSubviewToFront(tableView)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInformation.sharedInstance.friendNames.count+1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:FriendsPageCell = (self.tableView.dequeueReusableCellWithIdentifier("FriendCell"))! as! FriendsPageCell
        if(indexPath.row == 0) {
            cell.CellName.text = UserInformation.sharedInstance.name as String
            cell.TrackerSwitch.tag = 0
            let imageView = UIImageView()
            imageView.contentMode = .ScaleAspectFit
            cell.CellImage.image = FacebookImages.sharedInstance.profilePic
            cell.TrackerSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            cell.TrackerSwitch.on = true
            UserInformation.sharedInstance.isUserBeingTrackedArray[0] = true
        }else {
            cell.CellName.text = UserInformation.sharedInstance.friendNames[indexPath.row-1] as String
            let imageView = UIImageView()
            imageView.contentMode = .ScaleAspectFit
            cell.CellImage.image = FacebookImages.sharedInstance.dictionaryOfProfilePictures[UserInformation.sharedInstance.userIDsArray[indexPath.row]]
            cell.TrackerSwitch.tag = indexPath.row
            cell.TrackerSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            
        }
        return cell
    }
    
    func stateChanged(TrackerSwitch: UISwitch!)
    {
        print("Switch Changed")
        if (TrackerSwitch.on == true){
            ///Not best implementation, but simple
            UserInformation.sharedInstance.isUserBeingTrackedArray[TrackerSwitch.tag] = true
            if(TrackerSwitch.tag == 0 ) {
                print(UserInformation.sharedInstance.name, "  ",UserInformation.sharedInstance.isUserBeingTrackedArray[TrackerSwitch.tag])
            }else {
                print(UserInformation.sharedInstance.friendNames[TrackerSwitch.tag-1], "  ",UserInformation.sharedInstance.isUserBeingTrackedArray[TrackerSwitch.tag])
            }
        }
        else{
            
            UserInformation.sharedInstance.isUserBeingTrackedArray[TrackerSwitch.tag] = false
            if(TrackerSwitch.tag == 0 ) {
                print(UserInformation.sharedInstance.name, "  ",UserInformation.sharedInstance.isUserBeingTrackedArray[TrackerSwitch.tag])
            }else {
                print(UserInformation.sharedInstance.friendNames[TrackerSwitch.tag-1], "  ",UserInformation.sharedInstance.isUserBeingTrackedArray[TrackerSwitch.tag])
            }
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //sender.selected=!sender.selected;
        ////UserInformation.sharedInstance.currentPersonTrackingByIndex = indexPath.row
    }
    
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    /*
    func downloadImage(url: NSURL, cell : UITableViewCell){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                cell.imageView!.image = UIImage(data: data)
            }
        }
    }*/

    
}