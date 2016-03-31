//
//  AdminPropertiesTableViewCell.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-03-31.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

class AdminPropertiesTableViewCell: UITableViewCell {

    
    @IBOutlet var PropertyImage: UIImageView!
    @IBOutlet var PropertyNam: UILabel!
    @IBOutlet var PropertyAddr: UILabel!
    @IBOutlet var PropertyFeat: UILabel!
    @IBOutlet var RatingLabel: UILabel!
    @IBOutlet var PriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
