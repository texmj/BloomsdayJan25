//
//  ViewController.swift
//  BloomsdayApp
//
//  Created by Jason Schnagl on 11/18/15.
//  Copyright © 2015 Senior Design. All rights reserved.
//

import UIKit
import CoreData

class FBViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    var managedObjectContext : NSManagedObjectContext?

    //Segue to next menu automatically
    //Occurs when user logs in and if returning user.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HomeSegue" {
            print("PREPARINGFORSEGUE")
            returnUserData() //not necessary to have completion handler
            {
                    (result: UserInformation) in
            }
        }
    }
    
    //When the view loads, sets 2 observers and check if user logged in
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "observeProfileChange:", name: FBSDKProfileDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "observeTokenChange:", name: FBSDKAccessTokenDidChangeNotification, object: nil)

        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
        }
        print("FBVIEWCONTROLLER")
    }
    
    //
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //if user already logged in go to next screen'
            /*
            var oldToken: FBSDKAccessToken = notification.userInfo![FBSDKAccessTokenChangeOldKey]
            var newToken: FBSDKAccessToken = notification.userInfo![FBSDKAccessTokenChangeNewKey]
            NSLog("FB access token did change notification\nOLD token:\t%@\nNEW token:\t%@", oldToken.tokenString, newToken.tokenString)
            
            
            NSLog(@"FB access token did change notification\nOLD token:\t%@\nNEW token:\t%@", oldToken.tokenString, newToken.tokenString);
            */
            let nowDate: NSDate = NSDate()
            let fbExpirationDate = FBSDKAccessToken.currentAccessToken().expirationDate
            if fbExpirationDate.compare(nowDate) != NSComparisonResult.OrderedDescending {
                print("FB token: expired")
                // this means user launched the app after 60+ days of inactivity,
                // in this case FB SDK cannot refresh token automatically, so
                // you have to walk user thought the initial log in with FB flow
                // for the sake of simplicity, just logging user out from Facebook here
                //self.logoutFacebook()
                let loginManager = FBSDKLoginManager()
                loginManager.logOut()
            }else
            {
                dispatch_async(dispatch_get_main_queue()) {
                    [unowned self] in
                    self.performSegueWithIdentifier("HomeSegue", sender: self)
                }
            }
            
        }
        print("END OF FACEBOOK VIEW DID APPEAR")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //If the FBSDK Profile has changed... should not happen for 1 time login
    func observeProfileChange(notfication: NSNotification) {
        print("\n\nobserveProfileChange\n")
        if (FBSDKAccessToken.currentAccessToken() != nil) {///(FBSDKProfile.currentProfile() != nil) {
           //Is this needed?
            print("HERE!!!! observeProfileDidchange")
            /*dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("HomeSegue", sender: self)
            }*/
            
        }
    }
    /*
    func observeTokenChange(notification: NSNotification) {
        if (notification.name == FBSDKAccessTokenDidChangeNotification) {
            var oldToken: FBSDKAccessToken? = notification.userInfo?[FBSDKAccessTokenChangeOldKey] as? FBSDKAccessToken
            var newToken: FBSDKAccessToken? = notification.userInfo?[FBSDKAccessTokenChangeNewKey] as? FBSDKAccessToken
            print("FB access token did change notification\nOLD token:\t%@\nNEW token:\t%@", oldToken!.tokenString, newToken!.tokenString)
            // initial token setup when user is logged in
            if newToken != nil && oldToken == nil {
                // check the expiration data
                // IF token is not expired
                // THEN log user out
                // ELSE sync token with the server
                var nowDate: NSDate = NSDate()
                var fbExpirationDate: NSDate = FBSDKAccessToken.currentAccessToken().expirationDate
                //if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
                if fbExpirationDate.compare(nowDate) != NSComparisonResult.OrderedDescending {
                    print("FB token: expired")
                    // this means user launched the app after 60+ days of inactivity,
                    // in this case FB SDK cannot refresh token automatically, so
                    // you have to walk user thought the initial log in with FB flow
                    // for the sake of simplicity, just logging user out from Facebook here
                    //self.logoutFacebook()
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut()
                }
                else
                {
                    self.syncFacebookAccessTokenWithServer()
                }
                // change in token string
                if newToken != nil && oldToken != nil && !(oldToken.tokenString == newToken.tokenString) {
                    NSLog("FB access token string did change")
                    self.syncFacebookAccessTokenWithServer()
                }
                else if newToken == nil && oldToken != nil {
                    NSLog("FB access token string did become nil")
                }
                
                // upon token did change event we attempting to get FB profile info via current token (if exists)
                // this gives us an ability to check via OG API that the current token is valid
                self.requestFacebookUserInfo()
            }
        }
    }
    */


    
    //If the FBSDK token has changed...
    func observeTokenChange(notfication: NSNotification) {
        print("\n\nobserveTokenChange\n")
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            //continueButton.setTitle("continue as a guest", forState: UIControlState.Normal)
        }
        else {
            ///ObserveProfileChange(nil)
            print("OBSERVER USER DATA?")
            
            //returnUserData()
            //{
            //    (result: UserInformation) in
                //print("got back: \(result)")
            //}
            //let title: String = "continue as \(UserInfo.name)"
            //continueButton.setTitle(title, forState: UIControlState.Normal)
        }
    }

    // Facebook Delegate Methods
    //Login Button
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("\n\nUser Logged In")
        print(FBSDKAccessToken.currentAccessToken())
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("HomeSegue", sender: self)
            }
        }
    }
    
    //Logout Button
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    //Uses the accesstoken to grab all the userinformation from facebook and put it in userInformation
    func returnUserData(completion: (result: UserInformation) throws -> Void)
    {
        do {
             try completion(result: UserInformation.sharedInstance)
        } catch {
            print("Erorr occured, probably because token expired...")
            //log user out?
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            
        } /*catch pattern 2 where condition {
            statements
        }*/
        
       
    }


}
