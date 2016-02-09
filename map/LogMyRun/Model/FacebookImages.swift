//
// FacebookImages.swift
// test
//
// Created by Sarah Prata on 2/6/16.
// Copyright © 2016 codemysource. All rights reserved.
//
import Foundation
import CoreData

public class FacebookImages {
    public static let sharedInstance = FacebookImages()
    var profilePic : UIImage
    var allTheProfilePic : [UIImage]
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    private init()
    {
        self.profilePic = UIImage(named: "logo")!
        self.allTheProfilePic = [UIImage(named: "logo")!]
        if let checkedUrl = NSURL(string: "https://graph.facebook.com/\(UserInformation.sharedInstance.token)/picture?type=large&return_ssl_resources=1") {
            let imageView = UIImageView()
            imageView.contentMode = .ScaleAspectFit
            getDataFromUrl(checkedUrl) { (data, response, error) in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    self.profilePic = UIImage(data: data)!
                }
            }
        }
        print("Unknown")
        for var i = 0; i < UserInformation.sharedInstance.friendNames.count; i++ {
            print(UserInformation.sharedInstance.friendNames[i])
            if let checkedUrl = NSURL(string: "https://graph.facebook.com/\(UserInformation.sharedInstance.friendIDs[i])/picture?type=large&return_ssl_resources=1") {
                let imageView = UIImageView()
                imageView.contentMode = .ScaleAspectFit
                getDataFromUrl(checkedUrl) { (data, response, error) in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        guard let data = data where error == nil else { return }
                        ////print(UserInformation.sharedInstance.friendIDs[i])
                        print(response?.suggestedFilename ?? "")
                        self.allTheProfilePic.append(UIImage(data: data)!)
                    }
                }
            }
        }
    }
}