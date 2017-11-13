//
//  TripViewCell.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import Foundation
import UIKit

class TripViewCell: UITableViewCell {
    
    @IBOutlet weak var departLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    @IBOutlet weak var matchedWithLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
