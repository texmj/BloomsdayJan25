//
//  UserInformation.swift
//  test
//
//  Created by Jason Schnagl on 1/26/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation


public class UserInformation {
    var completionHandler:((Float)->Void)!
    public static let sharedInstance = UserInformation()
    ///var picture : UIImage //= "https://graph.facebook.com/USER_ID/picture?width=300&height=300"
    var name : NSString
    var token : NSString
    var friends : NSDictionary
    var friendNames : [String]
    var friendIDs : [String]
    var userIDsArray : [String] //Array of all userIDs. First one will be User, rest will be friends. if want num in future use UInt64?
    var accesstoken : NSString
    var currentPersonTrackingByIndex : Int //0 is self
    var isUserBeingTrackedArray : [Bool]
    var isRunnerTransmittingData : Bool
    //var userInfoNotRecievedFlag : Bool
    ///This prevents others from using the default '()' initializer for this class.
    private init()
    {
        self.name = "test"
        self.token = "test"
        self.friends = [String: String]()
        self.friendNames = [String]()
        self.friendIDs = [String]()
        self.accesstoken = "test"
        self.currentPersonTrackingByIndex = 0 //0 is self
        self.isUserBeingTrackedArray = [Bool]()
        self.userIDsArray = [String]()
        self.isRunnerTransmittingData = true
        //self.userInfoNotRecievedFlag = false
        //self.picture = UIImage(named: "afternoon")!
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,name,friends", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {

                self.name = result.valueForKey("name") as! NSString
                self.token = result.valueForKey("id") as! NSString
                //let myfriends = result.valueForKey("friends") as! AnyObject
                //let friendlist: AnyObject = result.valueForKey("friends")! as AnyObject
                //self.friends = friendlist as! NSString
                //print(self.token, self.name); print("FBACCESSTOKEN:"); print(self.accesstoken);
                //print(self.friends);
                self.accesstoken = FBSDKAccessToken.currentAccessToken().tokenString
                
                self.friends = result.valueForKey("friends") as! NSDictionary
                self.isUserBeingTrackedArray.append(true)
                self.userIDsArray.append(self.token as String)
                ///print(self.friends)
                let data : NSArray = self.friends.objectForKey("data") as! NSArray
                //print(data.count)
                for i in 0...data.count-1 {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    self.friendNames.append(name)
                    self.friendIDs.append(id)
                    self.isUserBeingTrackedArray.append(false)
                    self.userIDsArray.append(id)
                    //print("the id value is \(id) for \(name)")
                }
                
                let facebookID = self.token
                let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1")!) { data, response, error in
                }
                task.resume()
                //SPRATA Double check this is ok here.....
                FacebookImages.sharedInstance
                
            }
        })
        
        
    }
    
    func checkWhoIsBeingTracked(personBeingTracked : Int) -> NSString{
        if(personBeingTracked == 0) {
            return name
        }else
        {
            return friendNames[personBeingTracked-1]
        }
        
    }
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    

}