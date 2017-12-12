//
//  TripViewCell.swift
//  SnowRide
//
//  Created by Phyllis Wong on 11/8/17.
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
            departsOnLabel.text =  "\(trip?.departsOn.description ?? Date().description)"
            returnsOnLabel.text = "\(trip?.returnsOn.description ?? Date().description)"
            matchedWithLabel.text = "match:"
        }
    }
}
