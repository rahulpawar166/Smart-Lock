//
//  CustomCell.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 24/04/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import SwipeCellKit


class CustomCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
