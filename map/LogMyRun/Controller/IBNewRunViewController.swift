//
//  NewRunViewController.swift
//  LogMyRun
//

import UIKit
import CoreData
import CoreLocation
import HealthKit
import MapKit


class IBNewRunViewController: UIViewController {
    
    var managedObjectContext : NSManagedObjectContext?
    var run:Run!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var level1: MKOverlayLevel!
    
    var seconds = 0.0
    var distance = 0.0
    var flagStartLocation = true
    var notStartLocation = false
    
    var runners = 0;
    var currentRunner = 0;
    lazy var locationManager : CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        
        //Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        
        return _locationManager
        
    }()
    
    lazy var locations = [CLLocation]()
    lazy var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customTabBarItem:UITabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "mapIcon"), selectedImage: UIImage(named: "mapIcon_white")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        self.tabBarItem = customTabBarItem
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDel.managedObjectContext
        initUI()
        
        // Do any additional setup after loading the view.
    }
    
    func initUI()
    {
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 14)
        distanceLabel.font = UIFont(name: distanceLabel.font.fontName, size: 14)
        paceLabel.font = UIFont(name: paceLabel.font.fontName, size: 14)
        timeLabel.text = "00:00:00"
        distanceLabel.text = "--"
        paceLabel.text = "--"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @IBAction func startAction(sender: UIButton)
    {
        startButton.removeTarget(self, action: "startAction:", forControlEvents: UIControlEvents.TouchUpInside)
        startButton.addTarget(self, action: "stopAction:", forControlEvents: UIControlEvents.TouchUpInside)
        startButton.setTitle("STOP", forState: UIControlState.Normal)
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepCapacity: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "eachSecond:", userInfo: nil, repeats: true)
        
        startLocation()
    }
    
    @IBAction func stopAction(sender: UIButton)
    {
        startButton.removeTarget(self, action: "stopAction:", forControlEvents: UIControlEvents.TouchUpInside)
        startButton.addTarget(self, action: "startAction:", forControlEvents: UIControlEvents.TouchUpInside)
        startButton.setTitle("START", forState: UIControlState.Normal)
        let actionSheetController = UIAlertController (title: "Run Stopped", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Add Cancle-Action
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        //Add Save-Action
        actionSheetController.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (actionSheetController) -> Void in
            self.saveRun()
            self.performSegueWithIdentifier("ShowRunDetail", sender: nil)
        }))
        
        //Add Discard-Action
        actionSheetController.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: { (actionSheetController) -> Void in

            self.stopLocation()
        }))
        
        //present actionSheetController
        presentViewController(actionSheetController, animated: true, completion: nil)
        
        
    }
    
   // MARK: - Location Handler
    func startLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepCapacity: false)
        timer.invalidate()
        mapView.removeOverlays(mapView.overlays)
        
    }
    func eachSecond(timer : NSTimer) {
        seconds++
        
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
        
        timeLabel.text = secondsQuantity.description
        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
        distanceLabel.text = distanceQuantity.description
        
        let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds/distance)
        paceLabel.text = paceQuantity.description
        
    }
    
    
     // MARK: - Start log the run
    //TODO implement flag to check if first coordinate (so it doesn't grab random val from DB)
    //TODO Stop the app from calling this function when saving the run
    //SPRATA: Added 2 new functions (for get and post calls) that work based on the userID
    //         need to implement them when we have a better handle on testing runners
    
    //This locationManager helps you find your friends
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations as [CLLocation] {
            
            
            let howRecent = location.timestamp.timeIntervalSinceNow
            
            if abs(howRecent) < 10 && location.horizontalAccuracy < 20 {
                var coords = [CLLocationCoordinate2D]()
                var curLocation = location.coordinate // self.locations.last!.coordinate;
                var prevLocation = curLocation
                
                //Update distance
                for var i = 0; i < UserInformation.sharedInstance.userIDsArray.count-1; i++ {
                   
                    
                    print(UserInformation.sharedInstance.userIDsArray[i], UserInformation.sharedInstance.isUserBeingTrackedArray[i])
                    
                    if self.locations.count > 0 && UserInformation.sharedInstance.isUserBeingTrackedArray[i]
                    {
                        print("HERE for", UserInformation.sharedInstance.userIDsArray[i])
                        
                        let dispatchGroup = dispatch_group_create()
                        dispatch_group_enter(dispatchGroup) // enter group
                        
                        
                        returnPreviousLocationFromServerByUserID( UserInformation.sharedInstance.userIDsArray[i],completionClosure: { (success,lat,lon, userIDSame) -> Void in
                            // When download completes,control flow goes here.
                            if (success != nil) {
                                if(!self.flagStartLocation){ //make sure not first run
                                    //var mylocation = [[CLLocation alloc] initWithLatitude:lat! longitude:lon!];
                                    
                                    self.distance += location.distanceFromLocation(CLLocation(latitude: prevLocation.latitude, longitude: prevLocation.longitude))//self.locations.last!)
                                    
                                    print("Count of Coords", coords.count)
                                    print("prevLocation: ", prevLocation.latitude, prevLocation.longitude)
                                    curLocation.latitude = lat!
                                    curLocation.longitude = lon!

                                    
                                    //coords.append(prevLocation)
                                    coords.append(curLocation)
                                    
                                let region = MKCoordinateRegionMakeWithDistance(curLocation, 500, 500)
                                //Required to change the visual within a thread
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    self.mapView.setRegion(region, animated: true)
                                    self.mapView.addOverlay(MKPolyline(coordinates: &coords, count: coords.count))
                                })
                                    //note after appended!
                                    prevLocation.latitude = lat!
                                    prevLocation.longitude = lon!
                                    
                                }else if(self.notStartLocation) {
                                    print("First time, set lat&lon different")
                                    prevLocation.latitude = lat!
                                    prevLocation.longitude = lon!
                                    self.flagStartLocation = false
                                } else {
                                    print("First time, set lat&lon different")
                                    prevLocation.latitude = lat!
                                    prevLocation.longitude = lon!

                                }// set this to false after first for loop
                                /**********IMPORTANT**********/
                                //!!!! This needs to change so only sends the runners information if they specify they want to be tracked!!!!!!!!!!!!!
                                if(UserInformation.sharedInstance.userIDsArray[i] == UserInformation.sharedInstance.token)
                                {
                                    
                                    self.sendDistanceInformationToServerWithUserID(curLocation.latitude, lon: curLocation.longitude, userID: userIDSame!);
                                }
                                
                            } else {
                                // download fail
                                print("Something went wrong in locationManager()")
                            }
                            //leave group
                            dispatch_group_leave(dispatchGroup)
                        })
                        // this line block while loop until the async task above completed
                        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER)
                        
                        ///self.mapView.showsUserLocation = true;
                    }
                }
                //save location
                self.locations.append(CLLocation(latitude: curLocation.latitude, longitude: curLocation.longitude))
                notStartLocation = true
                print(notStartLocation, "<notStartlocation")
            }
        }
    }
 
    
    
    
    
    func sendDistanceInformationToServer( lat: Double, lon: Double)
    {
        let postHeaders = [
            "access-token": UserInformation.sharedInstance.accesstoken as String,
        ]
        
        let request2 = NSMutableURLRequest(URL: NSURL(string: "http://52.33.234.200:8080/api/runner/?latitude=\(lat)&longitude=\(lon)&timestamp=99999&id=\(UserInformation.sharedInstance.token)")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request2.HTTPMethod = "POST"
        request2.allHTTPHeaderFields = postHeaders
        
        let session2 = NSURLSession.sharedSession()
        let dataTask2 = session2.dataTaskWithRequest(request2, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                //let httpResponse = response as? NSHTTPURLResponse
                //print(httpResponse)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            }
        })
        
        dataTask2.resume()
        
    }
    
    
    func sendDistanceInformationToServerWithUserID( lat: Double, lon: Double, userID: String)
    {
        print("The UserID is", userID)
        let postHeaders = [
            "access-token": UserInformation.sharedInstance.accesstoken as String,
        ]
        
        let request2 = NSMutableURLRequest(URL: NSURL(string: "http://52.33.234.200:8080/api/runner/?latitude=\(lat)&longitude=\(lon)&timestamp=99999&id=\(userID)")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request2.HTTPMethod = "POST"
        request2.allHTTPHeaderFields = postHeaders
        
        let session2 = NSURLSession.sharedSession()
        let dataTask2 = session2.dataTaskWithRequest(request2, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                //let httpResponse = response as? NSHTTPURLResponse
                //print(httpResponse)
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            }
        })
        
        dataTask2.resume()
        
    }
    

    
    
    func returnPreviousLocationFromServerByUserID(userID: String, completionClosure: (success:Bool?, lat:Double?, lon:Double?, userIDSame:String?) -> Void ) -> (latitude: Double, longitude: Double, userIDSame: String) {
        var latFromServer = "0.0";
        var lonFromServer = "0.0";
        let headers = [
            "access-token": UserInformation.sharedInstance.accesstoken as String
        ]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://52.33.234.200:8080/api/runner/?id=\(userID)")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completionClosure(success: false, lat: nil,lon: nil, userIDSame: nil)
                print(error)
            } else {
                let jsonResult = try!NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                latFromServer = jsonResult!["Latitude"] as! String
                lonFromServer = jsonResult!["Longitude"] as! String
                completionClosure(success: true, lat: Double(latFromServer), lon: Double(lonFromServer), userIDSame: userID)
            }
        })
        
        dataTask.resume()
        return(Double(latFromServer)!, Double(lonFromServer)!, userID)
        
    }
    
    
    
    func returnPreviousLocationFromServer(completionClosure: (success:Bool?, lat:Double?, lon:Double?) -> Void ) -> (latitude: Double, longitude: Double) {
        var latFromServer = "0.0";
        var lonFromServer = "0.0";
        let headers = [
            "access-token": UserInformation.sharedInstance.accesstoken as String
        ]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://52.33.234.200:8080/api/runner/?id=\(UserInformation.sharedInstance.token)")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completionClosure(success: false, lat: nil,lon: nil)
                print(error)
            } else {
                let jsonResult = try!NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                latFromServer = jsonResult!["Latitude"] as! String
                lonFromServer = jsonResult!["Longitude"] as! String
                completionClosure(success: true, lat: Double(latFromServer), lon: Double(lonFromServer))
            }
        })
        
        dataTask.resume()
        return(Double(latFromServer)!, Double(lonFromServer)!)
        
    }
    // MARK: - Save the run
    
    func saveRun()
    {
        let savedRun = NSEntityDescription.insertNewObjectForEntityForName("Run", inManagedObjectContext: managedObjectContext!) as! Run
        savedRun.distance = distance
        savedRun.duration = seconds
        savedRun.timestamp = NSDate()
        
        var savedLocations = [Location]()
        for location in locations {
            let savedLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedObjectContext!) as! Location
            savedLocation.timestamp = location.timestamp
            savedLocation.latitude = location.coordinate.latitude
            savedLocation.longitude = location.coordinate.longitude
            savedLocations.append(savedLocation)
        }
        savedRun.locations = NSOrderedSet(array: savedLocations)
        run = savedRun
        
        //handle errors
//        var error : NSError?
//        let success = managedObjectContext!.save()
        
        do {
            try managedObjectContext!.save()
        } catch {
            print("Could not save the run!")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let detailViewController = segue.destinationViewController as? IBRunDetailViewController {
            detailViewController.run = run
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension IBNewRunViewController : CLLocationManagerDelegate {
    
}

extension IBNewRunViewController : MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {

        let polyline = overlay as! MKPolyline
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        if currentRunner == 0 {
            renderer.strokeColor = UIColor.greenColor()
        }
        else {
            renderer.strokeColor = UIColor.redColor()
        }
        renderer.lineWidth = 3
        if currentRunner < runners {
            currentRunner++;
        }
        else {
            currentRunner = 0;
        }
        return renderer
    }
}