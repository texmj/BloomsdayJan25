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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Prep For Segue")
        if segue.identifier == "HomeSegue" {
            returnUserData() //not necessary to have completion handler
                {
                    (result: UserInformation) in
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "observeProfileChange:", name: FBSDKProfileDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "observeTokenChange:", name: FBSDKAccessTokenDidChangeNotification, object: nil)

        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            /*print("IS IT HERE?")
            // User is already logged in, go to next view controller.
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("HomeSegue", sender: self)
            }*/
        }
        else
        {
            //let loginView = loginButton //: FBSDKLoginButton = FBSDKLoginButton()
           // self.view.addSubview(loginView)
            //loginView.center = self.view.center
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        print("\n\n\nVIEW DID APPEAR\n\n\n\n")
        if (FBSDKAccessToken.currentAccessToken() != nil) {///(FBSDKProfile.currentProfile() != nil) {
            //Is this needed?
            print("HERE!!!! observeProfileDidchange")
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("HomeSegue", sender: self)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeProfileChange(notfication: NSNotification) {
        print("observeProfileChange")
        if (FBSDKAccessToken.currentAccessToken() != nil) {///(FBSDKProfile.currentProfile() != nil) {
           //Is this needed?
            print("HERE!!!! observeProfileDidchange")
            /*dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("HomeSegue", sender: self)
            }*/
            
        }
    }
    
    func observeTokenChange(notfication: NSNotification) {
        print("observeTokenChange")
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            //continueButton.setTitle("continue as a guest", forState: UIControlState.Normal)
        }
        else {
            ///bserveProfileChange(nil)
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
    //TODO INTEGRATE
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
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
            print("HERE!!--!!")
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("HomeSegue", sender: self)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData(completion: (result: UserInformation) -> Void)
    {
        //let runner = UserInformation.sharedInstance
        //print(runner.name)
        completion(result: UserInformation.sharedInstance)
    }


}
