//
//  FriendsTableViewController.swift
//  LogMyRun
//
//  Created by Sarah Prata on 2/1/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation
//@IBOutlet var tableView: UITableView!

class FriendsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet var tableView: UITableView
    var items: [NSString] = ["We", "Heart", "Swift"]
    var friendImages = [UIImage]()
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
                self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInformation.sharedInstance.friendNames.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCellWithIdentifier("cell"))! as UITableViewCell
        
        cell.textLabel?.text = UserInformation.sharedInstance.friendNames[indexPath.row] as String
                //asyncronous:
        //SPRATA DYNAMICALLY GET FRIEND PICTURES!!!!
        if let checkedUrl = NSURL(string: "https://graph.facebook.com/\(UserInformation.sharedInstance.friendIDs[indexPath.row])/picture?type=large&return_ssl_resources=1") {
            let imageView = UIImageView()
            imageView.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl, cell: cell)
        }
        
        let items = ["Purple", "Green"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
        ///cell.contentView = UISegmentedControl(items: items)
        let segmentController = UISegmentedControl()
        segmentController.frame = CGRectMake(100, 25, 100, 30)
        //segment frame size
        segmentController.insertSegmentWithTitle("first", atIndex: 0, animated: true)
        //inserting new segment at index 0
        segmentController.insertSegmentWithTitle("second", atIndex: 1, animated: true)
        //inserting new segment at index 1
        segmentController.backgroundColor = UIColor.blueColor()
        //setting the background color of the segment controller
        segmentController.selectedSegmentIndex = 0
        //setting the segment which is initially selected
        segmentController.addTarget(self, action: "segment:", forControlEvents: UIControlEvents.ValueChanged)
        //calling the selector method
        self.view.addSubview(segmentController)
        //adding the view as subview of the segment comntroller w.r.t. main view controller
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    
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
    }

    
}