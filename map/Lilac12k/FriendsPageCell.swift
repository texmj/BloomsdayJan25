//
//  FriendsPageCell.swift
//  Lilac12k
//
//  Created by Kaitlin Anderson on 2/8/16.
//  Copyright © 2016 codemysource. All rights reserved.
//

import UIKit

class FriendsPageCell: UITableViewCell {

    
    @IBOutlet weak var TrackerSwitch: UISwitch!
    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    //var cellIndex: Int = 0



    override func awakeFromNib() {
        super.awakeFromNib()
        TrackerSwitch.on = false

    }

    override func setSelected(selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
