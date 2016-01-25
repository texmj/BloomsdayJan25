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
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations as [CLLocation] {
            let howRecent = location.timestamp.timeIntervalSinceNow
            
            if abs(howRecent) < 10 && location.horizontalAccuracy < 20 {
                //Update distance
                if self.locations.count > 0
                {
                    distance += location.distanceFromLocation(self.locations.last!)
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    //var coords2 = [CLLocationCoordinate2D]()
                    var test = self.locations.last!.coordinate;
                    test.latitude += 0.0005;
                    test.longitude += 0.0005;
                    
                   // var test2 = location.coordinate;
                    //test2.latitude += 0.0005;
                   // test2.longitude += 0.0005;
                    
                   // coords2.append(test)
                   // coords2.append(test2)
                    
                    let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
                    mapView.setRegion(region, animated: true)
                    mapView.addOverlay(MKPolyline(coordinates: &coords, count: coords.count))
                    
                  //  mapView.addOverlay(MKPolyline(coordinates: &coords2, count: coords2.count))
                    
                }
                
                //save location
                self.locations.append(location)
            }
        }
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