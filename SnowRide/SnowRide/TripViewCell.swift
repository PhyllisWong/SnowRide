//
//  TripViewCell.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import Foundation
import UIKit

class TripViewCell: UITableViewCell {
    
    @IBOutlet weak var departsOnLabel: UILabel!
    @IBOutlet weak var returnsOnLabel: UILabel!
    @IBOutlet weak var matchedWithLabel: UILabel!
    
    var trip: Trip? {
        didSet {
            departsOnLabel.text = trip?.departsOn
            returnsOnLabel.text = trip?.returnsOn
            matchedWithLabel.text = "no match yet"
        }
    }
}
