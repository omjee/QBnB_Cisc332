//
//  MyBookingsTableViewCell.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class MyBookingsTableViewCell: UITableViewCell {

    @IBOutlet var BookString: UILabel!
    @IBOutlet var Start: UILabel!
    @IBOutlet var End: UILabel!
    @IBOutlet var Status: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
