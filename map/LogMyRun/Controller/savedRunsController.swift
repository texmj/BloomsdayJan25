

import Foundation
//@IBOutlet var tableView: UITableView!
class SavedRunController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var friendImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInformation.sharedInstance.friendNames.count+1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:savedRunCell = (self.tableView.dequeueReusableCellWithIdentifier("runCell"))! as! savedRunCell
        
        //cell.cellDuration = 15
        
        return cell
    }
    
    
    
}