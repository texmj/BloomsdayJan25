
import UIKit

class RunPageCell: UITableViewCell {

    @IBOutlet weak var CellDistance: UILabel!
    @IBOutlet weak var CellDuration: UILabel!
    @IBOutlet weak var CellTimestamp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
