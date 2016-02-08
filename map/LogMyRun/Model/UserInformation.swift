//
//  UserInformation.swift
//  test
//
//  Created by Jason Schnagl on 1/26/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation


public class UserInformation {
    public static let sharedInstance = UserInformation()
    ///var picture : UIImage //= "https://graph.facebook.com/USER_ID/picture?width=300&height=300"
    var name : NSString
    var token : NSString
    var friends : NSDictionary
    var friendNames : [String]
    var friendIDs : [String]
    var accesstoken : NSString
    ///This prevents others from using the default '()' initializer for this class.
    private init()
    {
        self.name = "test"
        self.token = "test"
        self.friends = [String: String]()
        self.friendNames = [String]()
        self.friendIDs = [String]()
        self.accesstoken = "test"
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
                print("fetched user: \(result)")
                self.name = result.valueForKey("name") as! NSString
                self.token = result.valueForKey("id") as! NSString
                //let myfriends = result.valueForKey("friends") as! AnyObject
                //let friendlist: AnyObject = result.valueForKey("friends")! as AnyObject
                //self.friends = friendlist as! NSString
                print("\nDID IT CHANGE???")
                print(self.token);
                print(self.name);
                //print(friendlist);
                //print(self.friends);
                self.accesstoken = FBSDKAccessToken.currentAccessToken().tokenString
                print("FBACCESSTOKEN:")
                print(self.accesstoken)
                self.friends = result.valueForKey("friends") as! NSDictionary
                print("FRIENDS")
                ///print(self.friends)
                let data : NSArray = self.friends.objectForKey("data") as! NSArray
                print(data.count)
                for i in 0...data.count-1 {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    self.friendNames.append(name)
                    self.friendIDs.append(id)
                    print("the id value is \(id) for \(name)")
                }
                
               
                
                let facebookID = self.token
                let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1")!) { data, response, error in
                    print("~Here~")
                    print(response)
                }
                task.resume()
                
                
                                
                //print("User Name is: \(userName)")
                
                //let userEmail : NSString = result.valueForKey("email") as! NSString
                //print("User Email is: \(userEmail)")
            }
        })
        
        
    }
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    

}