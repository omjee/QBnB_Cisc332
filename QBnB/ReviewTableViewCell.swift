//
//  ReviewTableViewCell.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-30.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var AddressLabel: UILabel!
    @IBOutlet var RatingLabel: UILabel!
    @IBOutlet var ReviewLabel: UITextView!
    @IBOutlet var ResponseLabel: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
