//
//  TermsOfServiceViewController.swift
//  LogMyRun
//
//  Created by Jason Schnagl on 2/23/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import Foundation
import QuartzCore

class TermsOfServiceViewController: UIViewController {
    @IBOutlet var agreeButton: UIButton!
    @IBOutlet var scrollText: UITextView!
    //let colors = Colors()
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollText.scrollRangeToVisible(NSMakeRange(0, 0))
        //scrollText.setContentOffset(CGPointZero, animated: false)
        
        //scrollText.font = UIFont (name: "HelveticaNeue-Bold", size: 10)
        scrollText.scrollEnabled = false
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 18.0)! ]
        let myString = NSMutableAttributedString(string: "Privacy Policy \n\n", attributes: myAttribute )
        
        let myAttribute1 = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 12.0)! ]
        let myString1 = NSMutableAttributedString(string: "- Usage of the Lilac12k, gives Lilac12k access to your public Facebook profile and list of friends who have installed Lilac12k.  \n\n- Usage of Lilac12k's \"Run Tracking\" feature will periodically send your position (as determined by built-in GPS) and timestamp to a remote webserver. The webserver may send this information to anyone among your Facebook friends who has installed BBA.\n\nAny data sent to the BBA webserver (such as Facebook user ID, friend list, and most recent GPS coordinates) may be cached for an indefinite period of time.\n\n- The Lilac12k developers reserve the right to change this privacy policy at any time in the future.\n\n", attributes: myAttribute1 );
        let myString2 = NSMutableAttributedString(string: "\nTerms of Service\n\n", attributes: myAttribute );
        let myString3 = NSMutableAttributedString(string: "Account:\n\nUsage of the Lilac12k requires a Facebook account. You give Lilac12k permission to access your public profile and query your Facebook friends. For more on how your Facebook information is used, see our privacy policy.\n\nDisclaimer:\n\nLilac12k has no official affiliation with the Lilac Bloomsday Run or Gonzaga University.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.", attributes: myAttribute1 )
        //let text = "- Usage of the Lilac12k, gives Lilac12k access to your public Facebook profile and list of friends who have installed Lilac12k.  \n\n- Usage of Lilac12k's \"Run Tracking\" feature will periodically send your position (as determined by built-in GPS) and timestamp to a remote webserver. The webserver may send this information to anyone among your Facebook friends who has installed BBA.\n\nAny data sent to the BBA webserver (such as Facebook user ID, friend list, and most recent GPS coordinates) may be cached for an indefinite period of time.\n\n- The Lilac12k developers reserve the right to change this privacy policy at any time in the future.\n\n\n\nTerms of Service\n\nAccount:\n\nUsage of the Lilac12k requires a Facebook account. You give Lilac12k permission to access your public profile and query your Facebook friends. For more on how your Facebook information is used, see our privacy policy.\n\nDisclaimer:\nLilac12k has no official affiliation with the Lilac Bloomsday Run or Gonzaga University.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
        /*let linkTextWithColor = "SOFTWARE"
        
        let range = (text as NSString).rangeOfString(linkTextWithColor)
        */
        ///let attributedString = NSMutableAttributedString(string:myString1)
        // attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
        myString.appendAttributedString(myString1)
        myString.appendAttributedString(myString2)
        myString.appendAttributedString(myString3)
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSRange(location:0, length:myString.length));
        scrollText.attributedText = myString
        
        
        //scrollText.attributedText = myString
        scrollText.scrollEnabled = true
        refresh()
        //scrollText.setContentOffset(CGPointZero, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollText.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    func refresh() {
        //let topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
        //let bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
        let topColor = UIColor(red: (200/255.0), green: (200/255.0), blue: (200/255.0), alpha: 1)
        let bottomColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        
        let btnGradient : CAGradientLayer = CAGradientLayer()
        btnGradient.frame = agreeButton.bounds
        btnGradient.cornerRadius = 4
        btnGradient.colors = gradientColors
        agreeButton.layer.insertSublayer(btnGradient, atIndex: 0)
        
        //To add gradient to background
        /*
        scrollText.backgroundColor = UIColor.clearColor()
        let scrollBackgroundLayer = colors.gl
        scrollBackgroundLayer.frame = scrollText.frame
        scrollText.layer.insertSublayer(scrollBackgroundLayer, atIndex: 0)
        
        
        
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = colors.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        */
        
        
    }
    
}

